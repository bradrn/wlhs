module WLR.Render.Allocator where

#define WLR_USE_UNSTABLE
#include <wlr/render/allocator.h>

import Foreign
import Foreign.C.Types

import WL.ServerCore
import WLR.Backend
import WLR.Render.DrmFormatSet
import WLR.Render.Renderer
import WLR.Types.Buffer

type WLR_allocator_interface_create_buffer
    =  Ptr WLR_allocator
    -> CInt
    -> CInt
    -> Ptr WLR_drm_format
    -> IO (Ptr WLR_buffer)

type WLR_allocator_interface_destroy
    =  Ptr WLR_allocator
    -> IO ()

{{ struct(
    "wlr/render/allocator.h",
    "wlr_allocator_interface",
    "create_buffer", "FunPtr WLR_allocator_interface_create_buffer",
    "destroy", "FunPtr WLR_allocator_interface_destroy"
) }}

{{ struct(
    "wlr/render/allocator.h",
    "wlr_allocator",
    "impl", "Ptr WLR_allocator_interface",
    "buffer_caps", "Word32",
    "events destroy", "WL_signal"
) }}

foreign import capi "wlr/render/allocator.h wlr_allocator_autocreate"
    wlr_allocator_autocreate :: Ptr WLR_backend -> Ptr WLR_renderer -> IO (Ptr WLR_allocator)
