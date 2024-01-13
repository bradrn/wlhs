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

{{ struct wlr/types/wlr_pointer.h, wlr_pointer_impl }}

{{ struct
    wlr/types/wlr_pointer.h,
    wlr_pointer,
    base, WLR_input_device,
    impl, Ptr WLR_pointer_impl,
    output_name, CString,
    events motion, WL_signal,
    events motion_absolute, WL_signal,
    events button, WL_signal,
    events axis, WL_signal,
    events frame, WL_signal,
    events swipe_begin, WL_signal,
    events swipe_update, WL_signal,
    events swipe_end, WL_signal,
    events pinch_begin, WL_signal,
    events pinch_update, WL_signal,
    events pinch_end, WL_signal,
    events hold_begin, WL_signal,
    events hold_end, WL_signal
}}

{{ struct
    wlr/types/wlr_pointer.h,
    wlr_pointer_motion_event,
    pointer, Ptr WLR_pointer,
    time_msec, Word32,
    delta_x, CDouble,
    delta_y, CDouble,
    unaccel_dx, CDouble,
    unaccel_dy, CDouble
}}

{{ struct
    wlr/types/wlr_pointer.h,
    wlr_pointer_motion_absolute_event,
    pointer, Ptr WLR_pointer,
    time_msec, Word32,
    x, CDouble,
    y, CDouble,
}}

{{ struct
    wlr/types/wlr_pointer.h,
    wlr_pointer_button_event,
    pointer, Ptr WLR_pointer,
    time_msec, Word32,
    button, Word32,
    state, WLR_button_state_type
}}

{{ enum
    WLR_button_state_type,
    WLR_BUTTON_RELEASED,
    WLR_BUTTON_PRESSED
}}


{{ enum
    WLR_axis_source_type,
    WLR_AXIS_SOURCE_WHEEL,
    WLR_AXIS_SOURCE_FINGER,
    WLR_AXIS_SOURCE_CONTINUOUS,
    WLR_AXIS_SOURCE_WHEEL_TILT
}}

{{ enum
    WLR_axis_orientation_type,
    WLR_AXIS_ORIENTATION_VERTICAL,
    WLR_AXIS_ORIENTATION_HORIZONTAL
}}

pattern WLR_POINTER_AXIS_DISCRETE_STEP :: (Eq a, Num a) => a
pattern WLR_POINTER_AXIS_DISCRETE_STEP  = #const WLR_POINTER_AXIS_DISCRETE_STEP

{{ struct
   wlr/types/wlr_pointer.h,
   wlr_pointer_axis_event,
   pointer, Ptr WLR_pointer,
   time_msec, Word32,
   source, WLR_axis_source_type,
   orientation, WLR_axis_orientation_type,
   delta, CDouble,
   delta_discrete, Word32
}}

{{ struct
   wlr/types/wlr_pointer.h,
   wlr_pointer_swipe_begin_event,
   pointer, Ptr WLR_pointer,
   time_msec, Word32,
   fingers, Word32
}}

{{ struct
   wlr/types/wlr_pointer.h,
   wlr_pointer_swipe_update_event,
   pointer, Ptr WLR_pointer,
   time_msec, Word32,
   fingers, Word32,
   dx, CDouble,
   dy, CDouble
}}

{{ struct
   wlr/types/wlr_pointer.h,
   wlr_pointer_swipe_end_event,
   pointer, Ptr WLR_pointer,
   time_msec, Word32,
   cancelled, CBool
}}

data {-# CTYPE "wlr/types/wlr_pointer.h" "struct wlr_pointer_pinch_begin_event" #-} WLR_pointer_pinch_begin_event
    = WLR_pointer_pinch_begin_event
    { wlr_pointer_pinch_begin_event_pointer :: Ptr WLR_pointer
    , wlr_pointer_pinch_begin_event_time_msec :: Word32
    , wlr_pointer_pinch_begin_event_fingers :: Word32
    }

instance Storable WLR_pointer_pinch_begin_event where
    alignment _ = #alignment struct wlr_pointer_pinch_begin_event
    sizeOf _ = #size struct wlr_pointer_pinch_begin_event
    peek ptr = WLR_pointer_pinch_begin_event
        <$> (#peek struct wlr_pointer_pinch_begin_event, pointer) ptr
        <*> (#peek struct wlr_pointer_pinch_begin_event, time_msec) ptr
        <*> (#peek struct wlr_pointer_pinch_begin_event, fingers) ptr
    poke ptr t = do
        (#poke struct wlr_pointer_pinch_begin_event, pointer) ptr $ wlr_pointer_pinch_begin_event_pointer t
        (#poke struct wlr_pointer_pinch_begin_event, time_msec) ptr $ wlr_pointer_pinch_begin_event_time_msec t
        (#poke struct wlr_pointer_pinch_begin_event, fingers) ptr $ wlr_pointer_pinch_begin_event_fingers t

data {-# CTYPE "wlr/types/wlr_pointer.h" "struct wlr_pointer_pinch_update_event" #-} WLR_pointer_pinch_update_event
    = WLR_pointer_pinch_update_event
    { wlr_pointer_pinch_update_event_pointer :: Ptr WLR_pointer
    , wlr_pointer_pinch_update_event_time_msec :: Word32
    , wlr_pointer_pinch_update_event_fingers :: Word32
    -- |Relative coordinates of the logical center of the gesture
    -- |compared to the previous event.
    , wlr_pointer_pinch_update_event_dx :: CDouble
    , wlr_pointer_pinch_update_event_dy :: CDouble
    -- |Absolute scale compared to the begin event
    , wlr_pointer_pinch_update_event_scale :: CDouble
    -- |Relative angle in degrees clockwise compared to the previous event.
    , wlr_pointer_pinch_update_event_rotation :: CDouble
    }

instance Storable WLR_pointer_pinch_update_event where
    alignment _ = #alignment struct wlr_pointer_pinch_update_event
    sizeOf _ = #size struct wlr_pointer_pinch_update_event
    peek ptr = WLR_pointer_pinch_update_event
        <$> (#peek struct wlr_pointer_pinch_update_event, pointer) ptr
        <*> (#peek struct wlr_pointer_pinch_update_event, time_msec) ptr
        <*> (#peek struct wlr_pointer_pinch_update_event, fingers) ptr
        <*> (#peek struct wlr_pointer_pinch_update_event, dx) ptr
        <*> (#peek struct wlr_pointer_pinch_update_event, dy) ptr
        <*> (#peek struct wlr_pointer_pinch_update_event, scale) ptr
        <*> (#peek struct wlr_pointer_pinch_update_event, rotation) ptr
    poke ptr t = do
        (#poke struct wlr_pointer_pinch_update_event, pointer) ptr $ wlr_pointer_pinch_update_event_pointer t
        (#poke struct wlr_pointer_pinch_update_event, time_msec) ptr $ wlr_pointer_pinch_update_event_time_msec t
        (#poke struct wlr_pointer_pinch_update_event, fingers) ptr $ wlr_pointer_pinch_update_event_fingers t
        (#poke struct wlr_pointer_pinch_update_event, dx) ptr $ wlr_pointer_pinch_update_event_dx t
        (#poke struct wlr_pointer_pinch_update_event, dy) ptr $ wlr_pointer_pinch_update_event_dy t
        (#poke struct wlr_pointer_pinch_update_event, scale) ptr $ wlr_pointer_pinch_update_event_scale t
        (#poke struct wlr_pointer_pinch_update_event, rotation) ptr $ wlr_pointer_pinch_update_event_rotation t

data {-# CTYPE "wlr/types/wlr_pointer.h" "struct wlr_pointer_pinch_end_event" #-} WLR_pointer_pinch_end_event
    = WLR_pointer_pinch_end_event
    { wlr_pointer_pinch_end_event_pointer :: Ptr WLR_pointer
    , wlr_pointer_pinch_end_event_time_msec :: Word32
    , wlr_pointer_pinch_end_event_cancelled :: CBool
    }

instance Storable WLR_pointer_pinch_end_event where
    alignment _ = #alignment struct wlr_pointer_pinch_end_event
    sizeOf _ = #size struct wlr_pointer_pinch_end_event
    peek ptr = WLR_pointer_pinch_end_event
        <$> (#peek struct wlr_pointer_pinch_end_event, pointer) ptr
        <*> (#peek struct wlr_pointer_pinch_end_event, time_msec) ptr
        <*> (#peek struct wlr_pointer_pinch_end_event, cancelled) ptr
    poke ptr t = do
        (#poke struct wlr_pointer_pinch_end_event, pointer) ptr $ wlr_pointer_pinch_end_event_pointer t
        (#poke struct wlr_pointer_pinch_end_event, time_msec) ptr $ wlr_pointer_pinch_end_event_time_msec t
        (#poke struct wlr_pointer_pinch_end_event, cancelled) ptr $ wlr_pointer_pinch_end_event_cancelled t

data {-# CTYPE "wlr/types/wlr_pointer.h" "struct wlr_pointer_hold_begin_event" #-} WLR_pointer_hold_begin_event
    = WLR_pointer_hold_begin_event
    { wlr_pointer_hold_begin_event_pointer :: Ptr WLR_pointer
    , wlr_pointer_hold_begin_event_time_msec :: Word32
    , wlr_pointer_hold_begin_event_fingers :: Word32
    }

instance Storable WLR_pointer_hold_begin_event where
    alignment _ = #alignment struct wlr_pointer_hold_begin_event
    sizeOf _ = #size struct wlr_pointer_hold_begin_event
    peek ptr = WLR_pointer_hold_begin_event
        <$> (#peek struct wlr_pointer_hold_begin_event, pointer) ptr
        <*> (#peek struct wlr_pointer_hold_begin_event, time_msec) ptr
        <*> (#peek struct wlr_pointer_hold_begin_event, fingers) ptr
    poke ptr t = do
        (#poke struct wlr_pointer_hold_begin_event, pointer) ptr $ wlr_pointer_hold_begin_event_pointer t
        (#poke struct wlr_pointer_hold_begin_event, time_msec) ptr $ wlr_pointer_hold_begin_event_time_msec t
        (#poke struct wlr_pointer_hold_begin_event, fingers) ptr $ wlr_pointer_hold_begin_event_fingers t

data {-# CTYPE "wlr/types/wlr_pointer.h" "struct wlr_pointer_hold_end_event" #-} WLR_pointer_hold_end_event
    = WLR_pointer_hold_end_event
    { wlr_pointer_hold_end_event_pointer :: Ptr WLR_pointer
    , wlr_pointer_hold_end_event_time_msec :: Word32
    , wlr_pointer_hold_end_event_cancelled :: CBool
    }

instance Storable WLR_pointer_hold_end_event where
    alignment _ = #alignment struct wlr_pointer_hold_end_event
    sizeOf _ = #size struct wlr_pointer_hold_end_event
    peek ptr = WLR_pointer_hold_end_event
        <$> (#peek struct wlr_pointer_hold_end_event, pointer) ptr
        <*> (#peek struct wlr_pointer_hold_end_event, time_msec) ptr
        <*> (#peek struct wlr_pointer_hold_end_event, cancelled) ptr
    poke ptr t = do
        (#poke struct wlr_pointer_hold_end_event, pointer) ptr $ wlr_pointer_hold_end_event_pointer t
        (#poke struct wlr_pointer_hold_end_event, time_msec) ptr $ wlr_pointer_hold_end_event_time_msec t
        (#poke struct wlr_pointer_hold_end_event, cancelled) ptr $ wlr_pointer_hold_end_event_cancelled t

{-
- Get a struct wlr_pointer from a struct wlr_input_device.
- 
- Asserts that the input device is a pointer.
-}
foreign import capi "wlr/types/wlr_pointer.h wlr_pointer_from_input_device"
    wlr_pointer_from_input_device :: Ptr WLR_input_device -> IO (Ptr WLR_pointer)
