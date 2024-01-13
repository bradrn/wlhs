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

{{ struct
   wlr/types/wlr_pointer.h,
   wlr_pointer_pinch_begin_event,
   pointer, Ptr WLR_pointer,
   time_msec, Word32,
   fingers, Word32
}}

{{ struct
   wlr/types/wlr_pointer.h,
   wlr_pointer_pinch_update_event,
   pointer, Ptr WLR_pointer,
   time_msec, Word32,
   fingers, Word32,
   dx, CDouble,
   dy, CDouble,
   scale, CDouble,
   rotation, CDouble
}}

{{ struct
   wlr/types/wlr_pointer.h,
   wlr_pointer_pinch_end_event,
   pointer, Ptr WLR_pointer,
   time_msec, Word32,
   cancelled, CBool
}}

{{ struct
   wlr/types/wlr_pointer.h,
   wlr_pointer_hold_begin_event,
   pointer, Ptr WLR_pointer,
   time_msec, Word32,
   fingers, Word32
}}

{{ struct
   wlr/types/wlr_pointer.h,
   wlr_pointer_hold_end_event,
   pointer, Ptr WLR_pointer,
   time_msec, Word32,
   cancelled, CBool
}}

{-
- Get a struct wlr_pointer from a struct wlr_input_device.
- 
- Asserts that the input device is a pointer.
-}
foreign import capi "wlr/types/wlr_pointer.h wlr_pointer_from_input_device"
    wlr_pointer_from_input_device :: Ptr WLR_input_device -> IO (Ptr WLR_pointer)
