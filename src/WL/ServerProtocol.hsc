{-# LANGUAGE PatternSynonyms #-}
module WL.ServerProtocol where

import Foreign.C.Types (CInt)
import Foreign.C.Types

#include <wayland-server-protocol.h>


type WL_data_device_manager_dnd_action = CInt

pattern WL_DATA_DEVICE_MANAGER_DND_ACTION_NONE :: (Eq a, Num a) => a
pattern WL_DATA_DEVICE_MANAGER_DND_ACTION_NONE = 0

pattern WL_DATA_DEVICE_MANAGER_DND_ACTION_COPY :: (Eq a, Num a) => a
pattern WL_DATA_DEVICE_MANAGER_DND_ACTION_COPY = 1

pattern WL_DATA_DEVICE_MANAGER_DND_ACTION_MOVE :: (Eq a, Num a) => a
pattern WL_DATA_DEVICE_MANAGER_DND_ACTION_MOVE = 2

pattern WL_DATA_DEVICE_MANAGER_DND_ACTION_ASK :: (Eq a, Num a) => a
pattern WL_DATA_DEVICE_MANAGER_DND_ACTION_ASK = 4

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
