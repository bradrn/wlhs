{-# LANGUAGE PatternSynonyms #-}

module WL.ServerProtocol where

#include <wayland-server-protocol.h>

import Foreign.C.Types

data {-# CTYPE "wayland-server-protocol.h" "struct wl_display" #-} WL_display

{{ enum
    WL_output_subpixel,
    WL_OUTPUT_SUBPIXEL_UNKNOWN,
    WL_OUTPUT_SUBPIXEL_NONE,
    WL_OUTPUT_SUBPIXEL_HORIZONTAL_RGB,
    WL_OUTPUT_SUBPIXEL_HORIZONTAL_BGR,
    WL_OUTPUT_SUBPIXEL_VERTICAL_RGB,
    WL_OUTPUT_SUBPIXEL_VERTICAL_BGR
}}

{{ enum
    WL_output_transform,
    WL_OUTPUT_TRANSFORM_NORMAL,
    WL_OUTPUT_TRANSFORM_90,
    WL_OUTPUT_TRANSFORM_180,
    WL_OUTPUT_TRANSFORM_270,
    WL_OUTPUT_TRANSFORM_FLIPPED,
    WL_OUTPUT_TRANSFORM_FLIPPED_90,
    WL_OUTPUT_TRANSFORM_FLIPPED_180,
    WL_OUTPUT_TRANSFORM_FLIPPED_270
}}
