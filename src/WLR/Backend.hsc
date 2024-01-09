module WLR.Backend where

#define WLR_USE_UNSTABLE
#include <wlr/backend.h>

import Foreign
import Foreign.C.Types

import WL.ServerCore
import WL.ServerProtocol

{{ struct("wlr/backend.h", "wlr_session") }}
{{ struct("wlr/backend.h", "wlr_backend_impl") }}

{{ struct(
    "wlr/backend.h",
    "wlr_backend",
    "impl", "Ptr WLR_backend_impl",
    "events destroy", "WL_signal",
    "events new_input", "WL_signal",
    "events new_output", "WL_signal"
) }}

foreign import capi "wlr/backend.h wlr_backend_autocreate"
    wlr_backend_autocreate :: Ptr WL_display -> Ptr (Ptr WLR_session) -> IO (Ptr WLR_backend)

foreign import capi "wlr/backend.h wlr_backend_start"
    wlr_backend_start :: Ptr WLR_backend -> IO CBool

foreign import capi "wlr/backend.h wlr_backend_destroy"
    wlr_backend_destroy :: Ptr WLR_backend -> IO ()
