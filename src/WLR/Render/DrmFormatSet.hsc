module WLR.Render.DrmFormatSet where

#define WLR_USE_UNSTABLE
#include <wlr/render/drm_format_set.h>

import Foreign
import Foreign.C.Types

{{ struct(
    "wlr/renderer/drm_format_set.h",
    "wlr_drm_format",
    "format", "Word32",
    "len", "CSize",
    "capacity", "CSize",
    "modifiers", "Ptr Word64"
) }}
