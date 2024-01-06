{-# LANGUAGE EmptyDataDeriving, PatternSynonyms #-}

module WLR.Types.Pointer where

#define WLR_USE_UNSTABLE
#include <wlr/types/wlr_pointer.h>

import Foreign (Word32)
import Foreign.C.Types (CDouble, CInt, CBool)
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

data {-# CTYPE "wlr/types/wlr_pointer.h" "struct wlr_pointer_button_event" #-} WLR_pointer_button_event
    = WLR_pointer_button_event
    { wlr_pointer_button_event_pointer :: Ptr WLR_pointer
    , wlr_pointer_button_event_time_msec :: Word32
    , wlr_pointer_button_event_button :: Word32
    , wlr_pointer_button_event_state :: WLR_button_state_type
    }

instance Storable WLR_pointer_button_event where
    alignment _ = #alignment struct wlr_pointer_button_event
    sizeOf _ = #size struct wlr_pointer_button_event
    peek ptr = WLR_pointer_button_event
        <$> (#peek struct wlr_pointer_button_event, pointer) ptr
        <*> (#peek struct wlr_pointer_button_event, time_msec) ptr
        <*> (#peek struct wlr_pointer_button_event, button) ptr
        <*> (#peek struct wlr_pointer_button_event, state) ptr
    poke ptr t = do
        (#poke struct wlr_pointer_button_event, pointer) ptr $ wlr_pointer_button_event_pointer t
        (#poke struct wlr_pointer_button_event, time_msec) ptr $ wlr_pointer_button_event_time_msec t
        (#poke struct wlr_pointer_button_event, button) ptr $ wlr_pointer_button_event_button t
        (#poke struct wlr_pointer_button_event, state) ptr $ wlr_pointer_button_event_state t

type WLR_button_state_type = CInt

pattern WLR_BUTTON_RELEASED :: (Eq a, Num a) => a
pattern WLR_BUTTON_RELEASED = #const WLR_BUTTON_RELEASED

pattern WLR_BUTTON_PRESSED :: (Eq a, Num a) => a
pattern WLR_BUTTON_PRESSED = #const WLR_BUTTON_PRESSED

type WLR_axis_source_type = CInt
pattern WLR_AXIS_SOURCE_WHEEL :: (Eq a, Num a) => a
pattern WLR_AXIS_SOURCE_WHEEL = #const WLR_AXIS_SOURCE_WHEEL
pattern WLR_AXIS_SOURCE_FINGER :: (Eq a, Num a) => a
pattern WLR_AXIS_SOURCE_FINGER = #const WLR_AXIS_SOURCE_FINGER
pattern WLR_AXIS_SOURCE_CONTINUOUS :: (Eq a, Num a) => a
pattern WLR_AXIS_SOURCE_CONTINUOUS = #const WLR_AXIS_SOURCE_CONTINUOUS
pattern WLR_AXIS_SOURCE_WHEEL_TILT :: (Eq a, Num a) => a
pattern WLR_AXIS_SOURCE_WHEEL_TILT = #const WLR_AXIS_SOURCE_WHEEL_TILT

type WLR_axis_orientation_type = CInt
pattern WLR_AXIS_ORIENTATION_VERTICAL :: (Eq a, Num a) => a
pattern WLR_AXIS_ORIENTATION_VERTICAL = #const WLR_AXIS_ORIENTATION_VERTICAL
pattern WLR_AXIS_ORIENTATION_HORIZONTAL :: (Eq a, Num a) => a
pattern WLR_AXIS_ORIENTATION_HORIZONTAL = #const WLR_AXIS_ORIENTATION_HORIZONTAL

pattern WLR_POINTER_AXIS_DISCRETE_STEP :: (Eq a, Num a) => a
pattern WLR_POINTER_AXIS_DISCRETE_STEP  = #const WLR_POINTER_AXIS_DISCRETE_STEP

data {-# CTYPE "wlr/types/wlr_pointer.h" "struct wlr_pointer_axis_event" #-} WLR_pointer_axis_event
    = WLR_pointer_axis_event
    { wlr_pointer_axis_event_pointer :: Ptr WLR_pointer
    , wlr_pointer_axis_event_time_msec :: Word32
    , wlr_pointer_axis_event_source :: WLR_axis_source_type
    , wlr_pointer_axis_event_orientation :: WLR_axis_orientation_type
    , wlr_pointer_axis_event_delta :: CDouble
    , wlr_pointer_axis_event_delta_discrete :: Word32
    }

instance Storable WLR_pointer_axis_event where
    alignment _ = #alignment struct wlr_pointer_axis_event
    sizeOf _ = #size struct wlr_pointer_axis_event
    peek ptr = WLR_pointer_axis_event
        <$> (#peek struct wlr_pointer_axis_event, pointer) ptr
        <*> (#peek struct wlr_pointer_axis_event, time_msec) ptr
        <*> (#peek struct wlr_pointer_axis_event, source) ptr
        <*> (#peek struct wlr_pointer_axis_event, orientation) ptr
        <*> (#peek struct wlr_pointer_axis_event, delta) ptr
        <*> (#peek struct wlr_pointer_axis_event, delta_discrete) ptr
    poke ptr t = do
        (#poke struct wlr_pointer_axis_event, pointer) ptr $ wlr_pointer_axis_event_pointer t
        (#poke struct wlr_pointer_axis_event, time_msec) ptr $ wlr_pointer_axis_event_time_msec t
        (#poke struct wlr_pointer_axis_event, source) ptr $ wlr_pointer_axis_event_source t
        (#poke struct wlr_pointer_axis_event, orientation) ptr $ wlr_pointer_axis_event_orientation t
        (#poke struct wlr_pointer_axis_event, delta) ptr $ wlr_pointer_axis_event_delta t
        (#poke struct wlr_pointer_axis_event, delta_discrete) ptr $ wlr_pointer_axis_event_delta_discrete t

data {-# CTYPE "wlr/types/wlr_pointer.h" "struct wlr_pointer_swipe_begin_event" #-} WLR_pointer_swipe_begin_event
    = WLR_pointer_swipe_begin_event
    { wlr_pointer_swipe_begin_event_pointer :: Ptr WLR_pointer
    , wlr_pointer_swipe_begin_event_time_msec :: Word32
    , wlr_pointer_swipe_begin_event_fingers :: Word32
    }

instance Storable WLR_pointer_swipe_begin_event where
    alignment _ = #alignment struct wlr_pointer_swipe_begin_event
    sizeOf _ = #size struct wlr_pointer_swipe_begin_event
    peek ptr = WLR_pointer_swipe_begin_event
        <$> (#peek struct wlr_pointer_swipe_begin_event, pointer) ptr
        <*> (#peek struct wlr_pointer_swipe_begin_event, time_msec) ptr
        <*> (#peek struct wlr_pointer_swipe_begin_event, fingers) ptr
    poke ptr t = do
        (#poke struct wlr_pointer_swipe_begin_event, pointer) ptr $ wlr_pointer_swipe_begin_event_pointer t
        (#poke struct wlr_pointer_swipe_begin_event, time_msec) ptr $ wlr_pointer_swipe_begin_event_time_msec t
        (#poke struct wlr_pointer_swipe_begin_event, fingers) ptr $ wlr_pointer_swipe_begin_event_fingers t

data {-# CTYPE "wlr/types/wlr_pointer.h" "struct wlr_pointer_swipe_update_event" #-} WLR_pointer_swipe_update_event
    = WLR_pointer_swipe_update_event
    { wlr_pointer_swipe_update_event_pointer :: Ptr WLR_pointer
    , wlr_pointer_swipe_update_event_time_msec :: Word32
    , wlr_pointer_swipe_update_event_fingers :: Word32
    -- |Relative coordinates of the logical center of the gesture
    -- |compared to the previous event.
    , wlr_pointer_swipe_update_event_dx :: CDouble
    , wlr_pointer_swipe_update_event_dy :: CDouble
    }

instance Storable WLR_pointer_swipe_update_event where
    alignment _ = #alignment struct wlr_pointer_swipe_update_event
    sizeOf _ = #alignment struct wlr_pointer_swipe_update_event
    peek ptr = WLR_pointer_swipe_update_event
        <$> (#peek struct wlr_pointer_swipe_update_event, pointer) ptr
        <*> (#peek struct wlr_pointer_swipe_update_event, time_msec) ptr
        <*> (#peek struct wlr_pointer_swipe_update_event, fingers) ptr
        <*> (#peek struct wlr_pointer_swipe_update_event, dx) ptr
        <*> (#peek struct wlr_pointer_swipe_update_event, dy) ptr
    poke ptr t = do
        (#poke struct wlr_pointer_swipe_update_event, pointer) ptr $ wlr_pointer_swipe_update_event_pointer t
        (#poke struct wlr_pointer_swipe_update_event, time_msec) ptr $ wlr_pointer_swipe_update_event_time_msec t
        (#poke struct wlr_pointer_swipe_update_event, fingers) ptr $ wlr_pointer_swipe_update_event_fingers t
        (#poke struct wlr_pointer_swipe_update_event, dx) ptr $ wlr_pointer_swipe_update_event_dx t
        (#poke struct wlr_pointer_swipe_update_event, dy) ptr $ wlr_pointer_swipe_update_event_dy t

data {-# CTYPE "wlr/types/wlr_pointer.h" "struct wlr_pointer_swipe_end_event" #-} WLR_pointer_swipe_end_event
    = WLR_pointer_swipe_end_event
    { wlr_pointer_swipe_end_event_pointer :: Ptr WLR_pointer
    , wlr_pointer_swipe_end_event_time_msec :: Word32
    , wlr_pointer_swipe_end_event_cancelled :: CBool
    }

instance Storable WLR_pointer_swipe_end_event where
    alignment _ = #alignment struct wlr_pointer_swipe_end_event
    sizeOf _ = #alignment struct wlr_pointer_swipe_end_event
    peek ptr = WLR_pointer_swipe_end_event
        <$> (#peek struct wlr_pointer_swipe_end_event, pointer) ptr
        <*> (#peek struct wlr_pointer_swipe_end_event, time_msec) ptr
        <*> (#peek struct wlr_pointer_swipe_end_event, cancelled) ptr
    poke ptr t = do
        (#poke struct wlr_pointer_swipe_end_event, pointer) ptr $ wlr_pointer_swipe_end_event_pointer t
        (#poke struct wlr_pointer_swipe_end_event, time_msec) ptr $ wlr_pointer_swipe_end_event_time_msec t
        (#poke struct wlr_pointer_swipe_end_event, cancelled) ptr $ wlr_pointer_swipe_end_event_cancelled t
