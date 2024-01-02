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

data {-# CTYPE "wlr/render/allocator.h" "struct wlr_allocator_interface" #-} WLR_allocator_interface
    = WLR_allocator_interface
    { wlr_allocator_interface_create_buffer :: FunPtr WLR_allocator_interface_create_buffer
    , wlr_allocator_interface_destroy :: FunPtr WLR_allocator_interface_destroy
    } deriving (Show)

instance Storable WLR_allocator_interface where
    alignment _ = #alignment struct wlr_allocator_interface
    sizeOf _ = #size struct wlr_allocator_interface
    peek ptr = WLR_allocator_interface
        <$> (#peek struct wlr_allocator_interface, create_buffer) ptr
        <*> (#peek struct wlr_allocator_interface, destroy) ptr
    poke ptr t = do
        (#poke struct wlr_allocator_interface, create_buffer) ptr $ wlr_allocator_interface_create_buffer t
        (#poke struct wlr_allocator_interface, destroy) ptr $ wlr_allocator_interface_destroy t

data {-# CTYPE "wlr/render/allocator.h" "struct wlr_allocator" #-} WLR_allocator
    = WLR_allocator
    { wlr_allocator_impl :: Ptr WLR_allocator_interface
    , wlr_allocator_buffer_caps :: Word32
    , wlr_allocator_events_destroy :: WL_signal
    } deriving (Show)

instance Storable WLR_allocator where
    alignment _ = #alignment struct wlr_allocator
    sizeOf _ = #size struct wlr_allocator
    peek ptr = WLR_allocator
        <$> (#peek struct wlr_allocator, impl) ptr
        <*> (#peek struct wlr_allocator, buffer_caps) ptr
        <*> (#peek struct wlr_allocator, events.destroy) ptr
    poke ptr t = do
        (#poke struct wlr_allocator, impl) ptr $ wlr_allocator_impl t
        (#poke struct wlr_allocator, buffer_caps) ptr $ wlr_allocator_buffer_caps t
        (#poke struct wlr_allocator, events.destroy) ptr $ wlr_allocator_events_destroy t

foreign import capi "wlr/render/allocator.h wlr_allocator_autocreate"
    wlr_allocator_autocreate :: Ptr WLR_backend -> Ptr WLR_renderer -> IO (Ptr WLR_allocator)
