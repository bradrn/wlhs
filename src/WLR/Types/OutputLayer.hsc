{-# LANGUAGE EmptyDataDeriving #-}

module WLR.Types.OutputLayer where

#define WLR_USE_UNSTABLE
#include <wlr/types/wlr_output_layer.h>

import Foreign
import Foreign.C.Types

import PIXMAN.Pixman
import WL.ServerCore
import WL.Utils
import WLR.Types.Buffer
import WLR.Util.Addon
import WLR.Util.Box

{{ struct
    wlr/types/wlr_output_layer.h,
    wlr_output_layer,
    link,            WL_list,
    addons,          WLR_addon_set,
    events feedback, WL_signal,
    data,            Ptr (),
    src_box,         WLR_fbox,
    dst_box,         WLR_box
}}

{{ struct
    wlr/types/wlr_output_layer.h,
    wlr_output_layer_state,
    layer,    Ptr WLR_output_layer,
    buffer,   Ptr WLR_buffer,
    src_box,  WLR_fbox,
    dst_box,  WLR_box,
    damage,   Ptr PIXMAN_region32_t,
    accepted, CBool
}}
