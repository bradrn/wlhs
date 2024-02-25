{-# LANGUAGE EmptyDataDeriving, PatternSynonyms #-}

module PIXMAN.Pixman where

#include <pixman.h>

import Foreign
import Foreign.C.Types

type PIXMAN_region32_t = PIXMAN_region32
type PIXMAN_region32_data_t = PIXMAN_region32_data
type PIXMAN_box32_t = PIXMAN_box32

{{ struct
    pixman.h,
    pixman_region32,
    extents, PIXMAN_box32_t,
    data,    Ptr PIXMAN_region32_data_t
}}

{{ struct
    pixman.h,
    pixman_region32_data,
    size,     CLong,
    numRects, CLong
}}

{{ struct
    pixman.h,
    pixman_box32,
    x1, CInt,
    y1, CInt,
    x2, CInt,
    y2, CInt
}}
