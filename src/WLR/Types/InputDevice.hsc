{-# LANGUAGE EmptyDataDeriving #-}
{-# LANGUAGE PatternSynonyms #-}

module WLR.Types.InputDevice where

#define WLR_USE_UNSTABLE
#include <wlr/types/wlr_input_device.h>

import Foreign
import Foreign.C.Types

import WL.ServerCore

{{ enum
    WLR_input_device_type,
    WLR_INPUT_DEVICE_KEYBOARD,
    WLR_INPUT_DEVICE_POINTER,
    WLR_INPUT_DEVICE_TOUCH,
    WLR_INPUT_DEVICE_TABLET_TOOL,
    WLR_INPUT_DEVICE_TABLET_PAD,
    WLR_INPUT_DEVICE_SWITCH
}}

{{ struct
    wlr/types/wlr_input_device.h,
    wlr_input_device,
    type, WLR_input_device_type,
    vendor, CUInt,
    product, CUInt,
    name, CChar,
    events destroy, WL_signal,
    data, Ptr ()
}}
