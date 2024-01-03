{-# LANGUAGE EmptyDataDeriving #-}

module WLR.Types.InputDevice where

#define WLR_USE_UNSTABLE
#include <wlr/types/wlr_input_device.h>

import Foreign
import Foreign.C.Types

import WL.ServerCore

type WLR_input_device_type = CInt
#enum WLR_input_device_type, , \
    WLR_INPUT_DEVICE_KEYBOARD, \
    WLR_INPUT_DEVICE_POINTER, \
    WLR_INPUT_DEVICE_TOUCH, \
    WLR_INPUT_DEVICE_TABLET_TOOL, \
    WLR_INPUT_DEVICE_TABLET_PAD, \
    WLR_INPUT_DEVICE_SWITCH

data {-# CTYPE "wlr/types/wlr_input_device.h" "struct wlr_input_device" #-} WLR_input_device
    = WLR_input_device
    { wlr_input_device_type :: WLR_input_device_type
    , wlr_input_device_vendor :: CUInt
    , wlr_input_device_product :: CUInt
    , wlr_input_device_name :: Ptr CChar
    , wlr_input_device_events_destroy :: WL_signal
    , wlr_input_device_data :: Ptr ()
    } deriving (Show)

instance Storable WLR_input_device where
    alignment _ = #alignment struct wlr_input_device
    sizeOf _ = #size struct wlr_input_device
    peek ptr = WLR_input_device
        <$> (#peek struct wlr_input_device, type) ptr
        <*> (#peek struct wlr_input_device, vendor) ptr
        <*> (#peek struct wlr_input_device, product) ptr
        <*> (#peek struct wlr_input_device, name) ptr
        <*> (#peek struct wlr_input_device, events.destroy) ptr
        <*> (#peek struct wlr_input_device, data) ptr
    poke ptr t = do
        (#poke struct wlr_input_device, type) ptr $ wlr_input_device_type t
        (#poke struct wlr_input_device, vendor) ptr $ wlr_input_device_vendor t
        (#poke struct wlr_input_device, product) ptr $ wlr_input_device_product t
        (#poke struct wlr_input_device, name) ptr $ wlr_input_device_name t
        (#poke struct wlr_input_device, events.destroy) ptr $ wlr_input_device_events_destroy t
        (#poke struct wlr_input_device, data) ptr $ wlr_input_device_data t