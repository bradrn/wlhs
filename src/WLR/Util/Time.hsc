module WLR.Util.Time where

import Foreign.C.Types (CLong, CTime)
import Foreign.Storable (Storable(..))

#include <time.h>

{{ struct
    time.h,
    timespec,
    tv_sec, CTime,
    tv_nsec, CLong
}}
