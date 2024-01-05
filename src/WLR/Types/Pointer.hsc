{-# LANGUAGE EmptyDataDeriving #-}

module WLR.Types.Pointer where

#define WLR_USE_UNSTABLE
#include <wlr/types/wlr_pointer.h>

import Foreign (Word32)
import Foreign.C.Types (CDouble)
import Foreign.C.String (CString)
import Foreign.Ptr (Ptr)
import Foreign.Storable (Storable(..))

import WLR.Types.InputDevice (WLR_input_device)
import WL.ServerCore (WL_signal)

data {-# CTYPE "wlr/types/wlr_pointer.h" "struct wlr_pointer_impl" #-} WLR_pointer_impl
    deriving (Show)

data {-# CTYPE "wlr/types/wlr_pointer.h" "struct wlr_pointer" #-} WLR_pointer
    = WLR_pointer
    { wlr_pointer_base :: WLR_input_device
    , wlr_pointer_impl :: Ptr WLR_pointer_impl
    , wlr_pointer_output_name :: CString
    -- |struct wlr_pointer_motion_event
    , wlr_pointer_events_motion :: WL_signal
    -- |struct wlr_pointer_motion_absolute_event
    , wlr_pointer_events_motion_absolute :: WL_signal
    -- |struct wlr_pointer_button_event
    , wlr_pointer_events_button :: WL_signal
    -- |struct wlr_pointer_axis_event
    , wlr_pointer_events_axis :: WL_signal
    , wlr_pointer_events_frame :: WL_signal
    -- |struct wlr_pointer_swipe_begin_event
    , wlr_pointer_events_swipe_begin :: WL_signal
    -- |struct wlr_pointer_swipe_update_event
    , wlr_pointer_events_swipe_update :: WL_signal
    -- |struct wlr_pointer_swipe_end_event
    , wlr_pointer_events_swipe_end :: WL_signal
    -- |struct wlr_pointer_pinch_begin_event
    , wlr_pointer_events_pinch_begin :: WL_signal
    -- |struct wlr_pointer_pinch_update_event
    , wlr_pointer_events_pinch_update :: WL_signal
    -- |struct wlr_pointer_pinch_end_event
    , wlr_pointer_events_pinch_end :: WL_signal
    -- |struct wlr_pointer_hold_begin_event
    , wlr_pointer_events_hold_begin :: WL_signal
    -- |struct wlr_pointer_hold_end_event
    , wlr_pointer_events_hold_end :: WL_signal
    , wlr_pointer_data :: Ptr ()
    }

instance Storable WLR_pointer where
    alignment _ = #alignment struct wlr_pointer
    sizeOf _ = #size struct wlr_pointer
    peek ptr = WLR_pointer
        <$> (#peek struct wlr_pointer, base) ptr
        <*> (#peek struct wlr_pointer, impl) ptr
        <*> (#peek struct wlr_pointer, output_name) ptr
        <*> (#peek struct wlr_pointer, events.motion) ptr
        <*> (#peek struct wlr_pointer, events.motion_absolute) ptr
        <*> (#peek struct wlr_pointer, events.button) ptr
        <*> (#peek struct wlr_pointer, events.axis) ptr
        <*> (#peek struct wlr_pointer, events.frame) ptr
        <*> (#peek struct wlr_pointer, events.swipe_begin) ptr
        <*> (#peek struct wlr_pointer, events.swipe_update) ptr
        <*> (#peek struct wlr_pointer, events.swipe_end) ptr
        <*> (#peek struct wlr_pointer, events.pinch_begin) ptr
        <*> (#peek struct wlr_pointer, events.pinch_update) ptr
        <*> (#peek struct wlr_pointer, events.pinch_end) ptr
        <*> (#peek struct wlr_pointer, events.hold_begin) ptr
        <*> (#peek struct wlr_pointer, events.hold_end) ptr
        <*> (#peek struct wlr_pointer, data) ptr
    poke ptr t = do
        (#poke struct wlr_pointer, base) ptr $ wlr_pointer_base t
        (#poke struct wlr_pointer, impl) ptr $ wlr_pointer_impl t
        (#poke struct wlr_pointer, output_name) ptr $ wlr_pointer_output_name t
        (#poke struct wlr_pointer, events.motion) ptr $ wlr_pointer_events_motion t
        (#poke struct wlr_pointer, events.motion_absolute) ptr $ wlr_pointer_events_motion_absolute t
        (#poke struct wlr_pointer, events.button) ptr $ wlr_pointer_events_button t
        (#poke struct wlr_pointer, events.axis) ptr $ wlr_pointer_events_axis t
        (#poke struct wlr_pointer, events.frame) ptr $ wlr_pointer_events_frame t
        (#poke struct wlr_pointer, events.swipe_begin) ptr $ wlr_pointer_events_swipe_begin t
        (#poke struct wlr_pointer, events.swipe_update) ptr $ wlr_pointer_events_swipe_update t
        (#poke struct wlr_pointer, events.swipe_end) ptr $ wlr_pointer_events_swipe_end t
        (#poke struct wlr_pointer, events.pinch_begin) ptr $ wlr_pointer_events_pinch_begin t
        (#poke struct wlr_pointer, events.pinch_update) ptr $ wlr_pointer_events_pinch_update t
        (#poke struct wlr_pointer, events.pinch_end) ptr $ wlr_pointer_events_pinch_end t
        (#poke struct wlr_pointer, events.hold_begin) ptr $ wlr_pointer_events_hold_begin t
        (#poke struct wlr_pointer, events.hold_end) ptr $ wlr_pointer_events_hold_end t
        (#poke struct wlr_pointer, data) ptr $ wlr_pointer_data t

data {-# CTYPE "wlr/types/wlr_pointer.h" "struct wlr_pointer_motion_event" #-} WLR_pointer_motion_event
    = WLR_pointer_motion_event
    { wlr_pointer_motion_event_pointer :: Ptr WLR_pointer
    , wlr_pointer_motion_event_time_msec :: Word32
    , wlr_pointer_motion_event_delta_x :: CDouble
    , wlr_pointer_motion_event_delta_y :: CDouble
    , wlr_pointer_motion_event_unaccel_dx :: CDouble
    , wlr_pointer_motion_event_unaccel_dy :: CDouble
    }

instance Storable WLR_pointer_motion_event where
    alignment _ = #alignment struct wlr_pointer_motion_event
    sizeOf _ = #size struct wlr_pointer_motion_event
    peek ptr = WLR_pointer_motion_event
        <$> (#peek struct wlr_pointer_motion_event, pointer) ptr
        <*> (#peek struct wlr_pointer_motion_event, time_msec) ptr
        <*> (#peek struct wlr_pointer_motion_event, delta_x) ptr
        <*> (#peek struct wlr_pointer_motion_event, delta_y) ptr
        <*> (#peek struct wlr_pointer_motion_event, unaccel_dx) ptr
        <*> (#peek struct wlr_pointer_motion_event, unaccel_dy) ptr
    poke ptr t = do
        (#poke struct wlr_pointer_motion_event, pointer) ptr $ wlr_pointer_motion_event_pointer t
        (#poke struct wlr_pointer_motion_event, time_msec) ptr $ wlr_pointer_motion_event_time_msec t
        (#poke struct wlr_pointer_motion_event, delta_x) ptr $ wlr_pointer_motion_event_delta_x t
        (#poke struct wlr_pointer_motion_event, delta_y) ptr $ wlr_pointer_motion_event_delta_y t
        (#poke struct wlr_pointer_motion_event, unaccel_dx) ptr $ wlr_pointer_motion_event_unaccel_dx t
        (#poke struct wlr_pointer_motion_event, unaccel_dy) ptr $ wlr_pointer_motion_event_unaccel_dy t

data {-# CTYPE "wlr/types/wlr_pointer.h" "struct wlr_pointer_motion_absolute_event" #-} WLR_pointer_motion_absolute_event
    = WLR_pointer_motion_absolute_event
    { wlr_pointer_motion_absolute_event_pointer :: Ptr WLR_pointer
    , wlr_pointer_motion_absolute_event_time_msec :: Word32
    -- | From 0..1
    , wlr_pointer_motion_absolute_event_x :: CDouble
    -- | From 0..1
    , wlr_pointer_motion_absolute_event_y :: CDouble
    }

instance Storable WLR_pointer_motion_absolute_event where
    alignment _ = #alignment struct wlr_pointer_motion_absolute_event
    sizeOf _ = #size struct wlr_pointer_motion_absolute_event
    peek ptr = WLR_pointer_motion_absolute_event
        <$> (#peek struct wlr_pointer_motion_absolute_event, pointer) ptr
        <*> (#peek struct wlr_pointer_motion_absolute_event, time_msec) ptr
        <*> (#peek struct wlr_pointer_motion_absolute_event, x) ptr
        <*> (#peek struct wlr_pointer_motion_absolute_event, y) ptr
    poke ptr t = do
        (#poke struct wlr_pointer_motion_absolute_event, pointer) ptr $ wlr_pointer_motion_absolute_event_pointer t
        (#poke struct wlr_pointer_motion_absolute_event, time_msec) ptr $ wlr_pointer_motion_absolute_event_time_msec t
        (#poke struct wlr_pointer_motion_absolute_event, x) ptr $ wlr_pointer_motion_absolute_event_x t
        (#poke struct wlr_pointer_motion_absolute_event, y) ptr $ wlr_pointer_motion_absolute_event_y t
