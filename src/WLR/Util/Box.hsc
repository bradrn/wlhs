{-# LANGUAGE EmptyDataDeriving #-}
module WLR.Util.Box where

#include <wlr/util/box.h>

import Foreign
import Foreign.C.Types

{{ struct
    wlr/util/box.h,
    wlr_box,
    x, CInt,
    y, CInt,
    width, CInt,
    height, CInt
}}

{{ struct
    wlr/util/box.h,
    wlr_fbox,
    x, CDouble,
    y, CDouble,
    width, CDouble,
    height, CDouble
}}
