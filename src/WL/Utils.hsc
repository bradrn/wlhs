module WL.Utils where

#include <wayland-util.h>

import Foreign
import Foreign.C.Types

data {-# CTYPE "wayland-util.h" "struct wl_list" #-} WL_list
    = WL_list
    { wl_list_prev :: Ptr WL_list
    , wl_list_next :: Ptr WL_list
    } deriving (Show)

instance Storable WL_list where
    alignment _ = #alignment struct wl_list
    sizeOf _ = #size struct wl_list
    peek ptr = WL_list
        <$> (#peek struct wl_list, prev) ptr
        <*> (#peek struct wl_list, next) ptr
    poke ptr t = do
        (#poke struct wl_list, prev) ptr (wl_list_prev t)
        (#poke struct wl_list, next) ptr (wl_list_next t)

foreign import capi "wayland-util.h wl_list_init"
    wl_list_init :: Ptr WL_list -> IO ()

foreign import capi "wayland-util.h wl_list_insert"
    wl_list_insert :: Ptr WL_list -> Ptr WL_list -> IO ()

foreign import capi "wayland-util.h wl_list_remove"
    wl_list_remove :: Ptr WL_list -> IO ()

foreign import capi "wayland-util.h wl_list_length"
    wl_list_length :: Ptr WL_list -> IO CInt

foreign import capi "wayland-util.h wl_list_empty"
    wl_list_empty :: Ptr WL_list -> IO CInt
