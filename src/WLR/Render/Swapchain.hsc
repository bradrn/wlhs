{-# LANGUAGE EmptyDataDeriving, PatternSynonyms #-}

module WLR.Render.Swapchain where

#define WLR_USE_UNSTABLE
#include <wlr/render/swapchain.h>

import Foreign
import Foreign.C.Types

import WL.ServerCore
import WLR.Render.Allocator
import WLR.Render.DrmFormatSet
import WLR.Types.Buffer

{{ struct
    wlr/render/swapchain.h,
    wlr_swapchain_slot,
    buffer,   Ptr WLR_buffer,
    acquired, CBool,
    age,      CInt,
    release,  WL_listener
}}

{{ struct
    wlr/render/swapchain.h,
    wlr_swapchain,
    allocator,         Ptr WLR_allocator,
    width,             CInt,
    height,            CInt,
    format,            WLR_drm_format,
    slots,             [(#const WLR_SWAPCHAIN_CAP)]WLR_swapchain_slot,
    allocator_destroy, WL_listener
}}
