module WL.Version where

import Foreign.C.String

foreign import capi "wayland-version.h value WAYLAND_VERSION" wayland_version :: CString
