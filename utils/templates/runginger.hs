#!/usr/bin/env cabal

{- cabal:
build-depends: base, ginger, mtl, unordered-containers, text
-}

{-# LANGUAGE OverloadedStrings #-}

import Control.Monad.Writer (Writer)
import Data.Functor ((<&>))
import Data.Text (Text)
import Text.Ginger

import qualified Data.HashMap.Strict as HM
import qualified Data.Text as T
import qualified Data.Text.IO as T

type GVal' = GVal (Run SourcePos (Writer Text) Text)

pairs :: [a] -> [(a, a)]
pairs (a:b:as) = (a,b) : pairs as
pairs _        = []

asField :: Text -> Text -> Text
asField sep = T.intercalate sep . T.words

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
        <> "where\n    alignment _ = #alignment struct " <> ctype
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
     

context :: HM.HashMap Text (GVal')
context = HM.fromList
    [ ("struct", fromFunction $ pure . toGVal . mkStruct)
    , ("enum", fromFunction $ pure . toGVal . mkEnum)
    ]

main = do
  result <-
        parseGingerFile
          (fmap Just . readFile) -- include resolver
          "Pointer.hsc.jinja"
  case result of
    Left err -> print err
    Right result ->
        T.writeFile "RenderedPointer.hsc" $ easyRender context result
