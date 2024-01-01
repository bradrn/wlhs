module WL.ServerCore where

#include <wayland-server-core.h>

import Foreign
import Foreign.C.ConstPtr
import Foreign.C.Types

import WL.Utils
import WL.ServerProtocol

type WL_notify_func_t
    =  WL_listener
    -> Ptr ()
    -> IO ()

data {-# CTYPE "wayland-server-core.h" "struct wl_listener" #-} WL_listener
    = WL_listener
    { wl_listener_link :: Ptr WL_list
    , wl_listener_notify :: FunPtr WL_notify_func_t
    } deriving (Show)

instance Storable WL_listener where
    alignment _ = #alignment struct wl_listener
    sizeOf _ = #size struct wl_listener
    peek ptr = WL_listener
        <$> (#peek struct wl_listener, link) ptr
        <*> (#peek struct wl_listener, notify) ptr
    poke ptr t = do
        (#poke struct wl_listener, link) ptr $ wl_listener_link t
        (#poke struct wl_listener, notify) ptr $ wl_listener_notify t

newtype {-# CTYPE "wayland-server-core.h" "struct wl_signal" #-} WL_signal
    = WL_signal
    { wl_signal_listener_list :: WL_list
    } deriving (Show)

instance Storable WL_signal where
    alignment _ = #alignment struct wl_signal
    sizeOf _ = #size struct wl_signal
    peek ptr = WL_signal <$> (#peek struct wl_signal, listener_list) ptr
    poke ptr t = (#poke struct wl_signal, listener_list) ptr $ wl_signal_listener_list t

foreign import capi "wayland-server-core.h wl_signal_init"
    wl_signal_init :: Ptr WL_signal -> IO ()

foreign import capi "wayland-server-core.h wl_signal_add"
    wl_signal_add :: Ptr WL_signal -> Ptr WL_listener -> IO ()

foreign import capi "wayland-server-core.h wl_signal_get"
    wl_signal_get :: Ptr WL_signal -> FunPtr WL_notify_func_t -> IO ()

foreign import capi "wayland-server-core.h wl_signal_emit"
    wl_signal_emit :: Ptr WL_signal -> Ptr () -> IO ()

foreign import capi "wayland-server-core.h wl_display_create"
    wl_display_create :: IO (Ptr WL_display)

foreign import capi "wayland-server-core.h wl_display_destroy"
    wl_display_destroy :: Ptr WL_display -> IO ()

foreign import capi "wayland-server-core.h wl_display_add_socket_auto"
    wl_display_add_socket_auto :: Ptr WL_display -> IO (ConstPtr CChar)

foreign import capi "wayland-server-core.h wl_display_run"
    wl_display_run :: Ptr WL_display -> IO ()

foreign import capi "wayland-server-core.h wl_display_destroy_clients"
    wl_display_destroy_clients :: Ptr WL_display -> IO ()
