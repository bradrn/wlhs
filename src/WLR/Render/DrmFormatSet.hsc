module WLR.Render.DrmFormatSet where

#define WLR_USE_UNSTABLE
#include <wlr/render/drm_format_set.h>

import Foreign
import Foreign.C.Types

{{ struct
    wlr/render/drm_format_set.h,
    wlr_drm_format,
    format, Word32,
    len, CSize,
    capacity, CSize,
    modifiers, Ptr Word64
}}

{{ struct
    wlr/render/drm_format_set.h,
    wlr_drm_format_set,
    len, CSize,
    capacity, CSize,
    formats, Ptr WLR_drm_format
}}
