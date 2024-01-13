{-# LANGUAGE LambdaCase #-}
{-# LANGUAGE OverloadedStrings #-}

module Main where

import Data.Char (isSpace)
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
        source <- T.readFile inFile
        case process source of
            Left err -> do
                die' verbosity $ "in file " ++ inFile ++ ": " ++ err
            Right result -> do
                -- put result into a temporary file, then run existing
                -- hsc2hs preprocessor on that
                tmp <- getTemporaryDirectory
                withTempFile tmp (asTemplate inFile) $ \tmpFile handle -> do
                    debug verbosity $ "HscJinja: got temporary file: " ++ tmpFile
                    T.hPutStr handle result
                    hClose handle  -- make sure to finalise everything before hsc2hs reads it
                    runSimplePreProcessor
                        (ppHsc2hs bi lbi clbi)
                        tmpFile outFile verbosity
    }

asTemplate :: String -> String
asTemplate = fmap $ \case
    '/' -> '-'
    '\\' -> '-'
    c -> c

process :: Text -> Either String Text
process = fmap T.concat . traverse go . T.splitOn "{{"
  where
    go :: Text -> Either String Text
    go t = case T.breakOn "}}" t of
        (directive, after)
            | T.null after -> Right t  -- before the first {{
            | otherwise ->
                let (macro, args) = T.break isSpace $ T.strip directive
                    args' = T.strip <$> T.splitOn "," args
                    result = case T.strip macro of
                        "struct" -> Right $ mkStruct args'
                        "enum"   -> Right $ mkEnum   args'
                        m -> Left $ T.unpack $ "unknown macro: " <> m
                    after' = T.drop 2 after  -- get rid of }}
                in (<> after') <$> result

mkStruct :: [Text] -> Text
mkStruct args = dataDecl <> storableDecl
  where
    (cfile:ctype:fields') = args
    fields = pairs $ fields'

    hstype =
        let (prefix, t) = T.break (=='_') ctype
        in T.toUpper prefix <> t

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


mkEnum :: [Text] -> Text
mkEnum args = enumType <> "\n" <> enumPatterns
  where
    (hstype:rest) = args

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
