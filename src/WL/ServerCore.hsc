module WL.ServerCore where

#include <wayland-server-core.h>

import Foreign
import Foreign.C.String

import WL.Utils
import WL.ServerProtocol

type WL_notify_func_t
    =  WL_listener
    -> Ptr ()
    -> IO ()

{{ struct(
    "wayland-server-core.h",
    "wl_listener",
    "link", "Ptr WL_list",
    "notify", "FunPtr WL_notify_func_t"
) }}

{{ struct(
    "wayland-server-core.h",
    "wl_signal",
    "listener_list", "WL_list"
) }}

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
    wl_display_add_socket_auto :: Ptr WL_display -> IO CString

foreign import capi "wayland-server-core.h wl_display_run"
    wl_display_run :: Ptr WL_display -> IO ()

foreign import capi "wayland-server-core.h wl_display_destroy_clients"
    wl_display_destroy_clients :: Ptr WL_display -> IO ()
