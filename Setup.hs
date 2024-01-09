{-# LANGUAGE OverloadedStrings #-}

module Main where

import Control.Monad.Writer (Writer)
import Data.Functor ((<&>))
import Data.Text (Text)
import Distribution.Simple
import Distribution.Simple.PreProcess
import Distribution.Simple.Utils
import Distribution.Types.BuildInfo (BuildInfo)
import Distribution.Types.LocalBuildInfo (LocalBuildInfo)
import Distribution.Types.ComponentLocalBuildInfo (ComponentLocalBuildInfo)
import System.Directory (getTemporaryDirectory)
import System.IO (hClose)
import Text.Ginger

import qualified Data.HashMap.Strict as HM
import qualified Data.Text as T
import qualified Data.Text.IO as T

main :: IO ()
main = defaultMainWithHooks simpleUserHooks
    { -- override existing extension so Cabal has a file extension it knows already
      hookedPreProcessors = [("hsc", ppHscJinja)]
    }

ppHscJinja :: BuildInfo -> LocalBuildInfo -> ComponentLocalBuildInfo -> PreProcessor
ppHscJinja bi lbi clbi = PreProcessor
    { platformIndependent = False
    , ppOrdering = unsorted
    , runPreProcessor = mkSimplePreProcessor $ \inFile outFile verbosity -> do
        parsed <- parseGingerFile (fmap Just . readFile) inFile
        case parsed of
            Left err -> do
                source <- readFile inFile
                die' verbosity $ formatParserError (Just source) err
            Right result -> do
                -- put output into a temporary file, then run existing
                -- hsc2hs preprocessor on that
                tmp <- getTemporaryDirectory
                withTempFile tmp "wlhs.hsc" $ \tmpFile handle -> do
                    debug verbosity $ "HscJinja: got temporary file: " ++ tmpFile
                    T.hPutStr handle $ easyRender context result
                    hClose handle  -- make sure to finalise everything before hsc2hs reads it
                    runSimplePreProcessor
                        (ppHsc2hs bi lbi clbi)
                        tmpFile outFile verbosity
    }


type GVal' = GVal (Run SourcePos (Writer Text) Text)

context :: HM.HashMap Text (GVal')
context = HM.fromList
    [ ("struct", fromFunction $ pure . toGVal . mkStruct)
    , ("enum", fromFunction $ pure . toGVal . mkEnum)
    ]

mkStruct :: [(Maybe Text, GVal')] -> Text
mkStruct args = dataDecl <> storableDecl
  where
    (cfile':ctype':hstype':fields') = snd <$> args
    cfile = asText cfile'
    ctype = asText ctype'
    hstype = asText hstype'
    fields = pairs $ asText <$> fields'

    asHsField n = ctype <> "_" <> asField "_" n
    asCField n = asField "." n

    dataDecl =
        T.concat [ "data {-# CTYPE \"" , cfile , "\" \"struct ", ctype, "\" #-} " , hstype]
        <> if (null fields')
            then ""
            else T.concat [" = ", hstype, " { ", recordFields, " }"]
        <> " deriving Show"

    recordFields = T.intercalate ", " $
        fields <&> \(n, t) -> asHsField n <> " :: " <> t

    storableDecl
      | null fields' = ""
      | otherwise =
        "\n\ninstance Storable " <> hstype
        <> " where\n    alignment _ = #alignment struct " <> ctype
        <> "\n    sizeOf _ = #size struct " <> ctype
        <> "\n    peek ptr = " <> hstype <> " <$> " <> peekImpl
        <> "\n    poke ptr t = " <> pokeImpl

    peekImpl = T.intercalate " <*> " $
        fields <&> \(n, _) ->
            "(#peek struct " <> ctype <> ", " <> asCField n <> ") ptr"

    pokeImpl = T.intercalate " >> " $
        fields <&> \(n, _) ->
            "(#poke struct " <> ctype <> ", " <> asCField n
            <> ") ptr (" <> asHsField n <> " t)"


mkEnum :: [(Maybe Text, GVal')] -> Text
mkEnum args = enumType <> "\n" <> enumPatterns
  where
    (hstype':rest') = snd <$> args
    hstype = asText hstype'
    rest = asText <$> rest'

    enumType = "type " <> hstype <> " = CInt"

    enumPatterns = T.unlines $
        rest >>= \val ->
            [ "pattern " <> val <> " :: (Eq a, Num a) => a"
            , "pattern " <> val <> " = #const " <> val
            ]


pairs :: [a] -> [(a, a)]
pairs (a:b:as) = (a,b) : pairs as
pairs _        = []

asField :: Text -> Text -> Text
asField sep = T.intercalate sep . T.words
