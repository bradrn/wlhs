{-# LANGUAGE EmptyDataDeriving #-}

module WLR.Types.Buffer where

#define WLR_USE_UNSTABLE
#include <wlr/types/wlr_buffer.h>

import Foreign
import Foreign.C.Types

import WL.ServerCore
import WLR.Util.Addon

data {-# CTYPE "wlr/types/wlr_buffer.h" "struct wlr_buffer_impl" #-} WLR_buffer_impl
    deriving (Show)

data {-# CTYPE "wlr/types/wlr_buffer.h" "struct wlr_buffer" #-} WLR_buffer
    = WLR_buffer
    { wlr_buffer_impl :: Ptr WLR_buffer_impl
    , wlr_buffer_width :: CInt
    , wlr_buffer_height :: CInt
    , wlr_buffer_dropped :: CBool
    , wlr_buffer_n_locks :: CSize
    , wlr_buffer_accessing_data_ptr :: CBool
    , wlr_buffer_events_destroy :: WL_signal
    , wlr_buffer_events_release :: WL_signal
    , wlr_buffer_addons :: WLR_addon_set
    } deriving (Show)

instance Storable WLR_buffer where
    alignment _ = #alignment struct wlr_buffer
    sizeOf _ = #size struct wlr_buffer
    peek ptr = WLR_buffer
        <$> (#peek struct wlr_buffer, impl) ptr
        <*> (#peek struct wlr_buffer, width) ptr
        <*> (#peek struct wlr_buffer, height) ptr
        <*> (#peek struct wlr_buffer, dropped) ptr
        <*> (#peek struct wlr_buffer, n_locks) ptr
        <*> (#peek struct wlr_buffer, accessing_data_ptr) ptr
        <*> (#peek struct wlr_buffer, events.destroy) ptr
        <*> (#peek struct wlr_buffer, events.release) ptr
        <*> (#peek struct wlr_buffer, addons) ptr
    poke ptr t = do
        (#poke struct wlr_buffer, impl) ptr $ wlr_buffer_impl t
        (#poke struct wlr_buffer, width) ptr $ wlr_buffer_width t
        (#poke struct wlr_buffer, height) ptr $ wlr_buffer_height t
        (#poke struct wlr_buffer, dropped) ptr $ wlr_buffer_dropped t
        (#poke struct wlr_buffer, n_locks) ptr $ wlr_buffer_n_locks t
        (#poke struct wlr_buffer, accessing_data_ptr) ptr $ wlr_buffer_accessing_data_ptr t
        (#poke struct wlr_buffer, events.destroy) ptr $ wlr_buffer_events_destroy t
        (#poke struct wlr_buffer, events.release) ptr $ wlr_buffer_events_release t
        (#poke struct wlr_buffer, addons) ptr $ wlr_buffer_addons t
