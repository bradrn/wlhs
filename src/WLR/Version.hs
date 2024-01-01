module WLR.Version where

import Foreign.C.String

foreign import capi "wlr/version.h value WLR_VERSION_STR" wlr_version_str :: CString
