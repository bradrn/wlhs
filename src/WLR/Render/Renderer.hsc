module WLR.Render.Renderer where

#define WLR_USE_UNSTABLE
#include <wlr/render/wlr_renderer.h>

import Foreign
import Foreign.C.Types

import WL.ServerCore
import WL.ServerProtocol
import WLR.Backend

{{ struct wlr/render/wlr_renderer.h, wlr_renderer_impl }}

{{ struct
    wlr/render/wlr_renderer.h,
    wlr_renderer,
    events destroy, WL_signal,
    events lost, WL_signal,
    impl, Ptr WLR_renderer_impl,
    rendering, CBool,
    rendering_with_buffer, CBool
}}

foreign import capi "wlr/render/wlr_renderer.h wlr_renderer_autocreate"
    wlr_renderer_autocreate :: Ptr WLR_backend -> IO (Ptr WLR_renderer)

foreign import capi "wlr/render/wlr_renderer.h wlr_renderer_init_wl_display"
    wlr_renderer_init_wl_display :: Ptr WLR_renderer -> Ptr WL_display -> IO CBool
