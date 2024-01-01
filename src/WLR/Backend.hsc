module WLR.Backend where

#define WLR_USE_UNSTABLE
#include <wlr/backend.h>

import Foreign
import Foreign.C.Types

import WL.ServerCore
import WL.ServerProtocol

data {-# CTYPE "wlr/backend.h" "struct wlr_session" #-} WLR_session
data {-# CTYPE "wlr/backend.h" "struct wlr_backend_impl" #-} WLR_backend_impl

data {-# CTYPE "wlr/backend.h" "struct wlr_backend" #-} WLR_backend
    = WLR_backend
    { wlr_backend_impl :: Ptr WLR_backend_impl
    , wlr_backend_events_destroy :: WL_signal
    , wlr_backend_events_new_input :: WL_signal
    , wlr_backend_events_new_output :: WL_signal
    } deriving (Show)

instance Storable WLR_backend where
    alignment _ = #alignment struct wlr_backend
    sizeOf _ = #size struct wlr_backend
    peek ptr = WLR_backend
        <$> (#peek struct wlr_backend, impl) ptr
        <*> (#peek struct wlr_backend, events.destroy) ptr
        <*> (#peek struct wlr_backend, events.new_input) ptr
        <*> (#peek struct wlr_backend, events.new_output) ptr
    poke ptr t = do
        (#poke struct wlr_backend, impl) ptr $ wlr_backend_impl t
        (#poke struct wlr_backend, events.destroy) ptr $ wlr_backend_events_destroy t
        (#poke struct wlr_backend, events.new_input) ptr $ wlr_backend_events_new_input t
        (#poke struct wlr_backend, events.new_output) ptr $ wlr_backend_events_new_output t

foreign import capi "wlr/backend.h wlr_backend_autocreate"
    wlr_backend_autocreate :: Ptr WL_display -> Ptr (Ptr WLR_session) -> IO (Ptr WLR_backend)

foreign import capi "wlr/backend.h wlr_backend_start"
    wlr_backend_start :: Ptr WLR_backend -> IO CBool

foreign import capi "wlr/backend.h wlr_backend_destroy"
    wlr_backend_destroy :: Ptr WLR_backend -> IO ()
