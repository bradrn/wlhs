module Pixman.Types.Region where

import Foreign.C.Types (CInt, CLong)
import Foreign.Storable (Storable(..))
import Foreign.Ptr (Ptr)

#include <pixman.h>

{{ struct
    pixman.h,
    pixman_region32_data,
    size, CLong,
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

{{ struct
    pixman.h,
    pixman_region32,
    extents, PIXMAN_box32,
    data, Ptr PIXMAN_region32_data
}}
