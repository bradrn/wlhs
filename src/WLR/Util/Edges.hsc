{-# LANGUAGE PatternSynonyms #-}

module WLR.Util.Edges where

#include <wlr/util/edges.h>

import Foreign.C.Types

type WLR_edges = CInt

pattern WLR_EDGE_NONE :: (Eq a, Num a) => a
pattern WLR_EDGE_NONE = #const WLR_EDGE_NONE

pattern WLR_EDGE_TOP :: (Eq a, Num a) => a
pattern WLR_EDGE_TOP = #const WLR_EDGE_TOP

pattern WLR_EDGE_BOTTOM :: (Eq a, Num a) => a
pattern WLR_EDGE_BOTTOM = #const WLR_EDGE_BOTTOM

pattern WLR_EDGE_LEFT :: (Eq a, Num a) => a
pattern WLR_EDGE_LEFT = #const WLR_EDGE_LEFT

pattern WLR_EDGE_RIGHT :: (Eq a, Num a) => a
pattern WLR_EDGE_RIGHT = #const WLR_EDGE_RIGHT
