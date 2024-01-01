module WLR.Render.Renderer where

#define WLR_USE_UNSTABLE
#include <wlr/render/wlr_renderer.h>

import Foreign
import Foreign.C.Types

import WL.ServerCore
import WL.ServerProtocol
import WLR.Backend

data {-# CTYPE "wlr/render/wlr_renderer.h" "struct wlr_renderer_impl" #-} WLR_renderer_impl

data {-# CTYPE "wlr/render/wlr_renderer.h" "struct wlr_renderer" #-} WLR_renderer
    = WLR_renderer
    { wlr_renderer_events_destroy :: WL_signal
    , wlr_renderer_events_lost :: WL_signal
    -- | private state from here down
    , wlr_renderer_impl :: Ptr WLR_renderer_impl
    , wlr_renderer_rendering :: CBool
    , wlr_renderer_rendering_with_buffer :: CBool
    } deriving (Show)

instance Storable WLR_renderer where
    alignment _ = #alignment struct wlr_renderer
    sizeOf _ = #size struct wlr_renderer
    peek ptr = WLR_renderer
        <$> (#peek struct wlr_renderer, events.destroy) ptr
        <*> (#peek struct wlr_renderer, events.lost) ptr
        <*> (#peek struct wlr_renderer, impl) ptr
        <*> (#peek struct wlr_renderer, rendering) ptr
        <*> (#peek struct wlr_renderer, rendering_with_buffer) ptr
    poke ptr t = do
        (#poke struct wlr_renderer, events.destroy) ptr $ wlr_renderer_events_destroy t
        (#poke struct wlr_renderer, events.lost) ptr $ wlr_renderer_events_lost t
        (#poke struct wlr_renderer, impl) ptr $ wlr_renderer_impl t
        (#poke struct wlr_renderer, rendering) ptr $ wlr_renderer_rendering t
        (#poke struct wlr_renderer, rendering_with_buffer) ptr $ wlr_renderer_rendering_with_buffer t

foreign import capi "wlr/render/wlr_renderer.h wlr_renderer_autocreate"
    wlr_renderer_autocreate :: Ptr WLR_backend -> IO (Ptr WLR_renderer)

foreign import capi "wlr/render/wlr_renderer.h wlr_renderer_init_wl_display"
    wlr_renderer_init_wl_display :: Ptr WLR_renderer -> Ptr WL_display -> IO CBool
