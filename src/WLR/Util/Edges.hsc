{-# LANGUAGE PatternSynonyms #-}

module WLR.Util.Edges where

#include <wlr/util/edges.h>

import Foreign.C.Types

{{ enum
    WLR_edges,
    WLR_EDGE_NONE,
    WLR_EDGE_TOP,
    WLR_EDGE_BOTTOM,
    WLR_EDGE_LEFT,
    WLR_EDGE_RIGHT
}}
