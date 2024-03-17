{-# LANGUAGE PatternSynonyms #-}
module WLR.Types.Seat where


#define WLR_USE_UNSTABLE
#include <wlr/types/wlr_seat.h>
#include <time.h>

import Foreign.C.String (CString)
import Foreign.C.Types (CDouble(..), CInt(..), CBool, CSize, CBool(..))
-- if we upgrade our base libraries we can use this
-- https://github.com/haskell/core-libraries-committee/issues/118
-- import Foreign.C.ConstPtr
import Foreign.Ptr (Ptr, FunPtr)
import Foreign (peekArray, pokeArray, plusPtr, Word32, Int32)
import Foreign.Storable (Storable(..))

import WL.ServerProtocol (WL_display)
import WL.ServerCore (WL_signal, WL_listener)
import WL.Global (WL_global)
import WL.Client (WL_client)
import WL.Utils (WL_list)

import Time.Time (TIMESPEC)
import {-# SOURCE #-} WLR.Types.DataDevice (
    WLR_drag
    , WLR_data_source
    )
import WLR.Types.PrimarySelection (WLR_primary_selection_source)
import WLR.Types.Compositor (WLR_surface)
import WLR.Types.Pointer (
    WLR_axis_source_type
    , WLR_button_state_type
    , WLR_axis_orientation_type
    )
import WLR.Types.Keyboard (WLR_keyboard, WLR_keyboard_modifiers)

{{ struct
    wlr/types/wlr_seat.h,
    wlr_serial_range,
    min_incl, Word32,
    max_incl, Word32
}}

pattern WLR_SERIAL_RINGSET_SIZE :: (Eq a, Num a) => a
pattern WLR_SERIAL_RINGSET_SIZE = 128

{{ struct
    wlr/types/wlr_seat.h,
    wlr_serial_ringset,
    data, [WLR_SERIAL_RINGSET_SIZE] WLR_serial_range,
    end, CInt,
    count, CInt
}}

{{ struct
    wlr/types/wlr_seat.h,
    wlr_seat_client,
    client, Ptr WL_client,
    seat, Ptr WLR_seat,
    link, WL_list,
    resources, WL_list,
    pointers, WL_list,
    keyboards, WL_list,
    touches, WL_list,
    data_devices, WL_list,
    events destroy, WL_signal,
    serials, WLR_serial_ringset,
    needs_touch_frame, CBool,
    value120 acc_discrete, [2] Int32,
    value120 last_discrete, [2] Int32,
    value120 acc_axis, [2] CDouble,
}}

{{ struct
    wlr/types/seat.h,
    wlr_pointer_grab_interface,
    enter, FunPtr (Ptr WLR_seat_pointer_grab -> Ptr WLR_surface -> CDouble -> CDouble -> IO ()),
    clear_focus, FunPtr (Ptr WLR_seat_pointer_grab -> IO ()),
    motion, FunPtr (Ptr WLR_seat_pointer_grab -> Word32 -> CDouble -> CDouble -> ()),
    button, FunPtr (Ptr WLR_seat_pointer_grab -> Word32 -> Word32 -> WLR_button_state_type -> IO (Word32)),
    axis, FunPtr (Ptr WLR_seat_pointer_grab -> Word32 -> WLR_axis_orientation_type -> CDouble -> Int32 -> WLR_axis_source_type -> IO ()),
    frame, FunPtr (Ptr WLR_seat_pointer_grab -> IO ()),
    cancel, FunPtr (Ptr WLR_seat_pointer_grab -> IO ())
}}

{{ struct
    wlr/types/wlr_seat.h,
    wlr_seat_pointer_grab,
    interface, Ptr WLR_pointer_grab_interface,
    seat, Ptr WLR_seat,
    data, Ptr ()
}}

pattern WLR_POINTER_BUTTONS_CAP :: (Eq a, Num a) => a
pattern WLR_POINTER_BUTTONS_CAP = 16

{{ struct
    wlr/types/wlr_seat.h,
    wlr_seat_pointer_state,
    seat, Ptr WLR_seat,
    focused_client, Ptr WLR_seat_client,
    focused_surface, Ptr WLR_surface,
    sx, CDouble,
    sy, CDouble,
    grab, Ptr WLR_seat_pointer_grab,
    default_grab, Ptr WLR_seat_pointer_grab,
    sent_axis_source, CBool,
    cached_axis_source, WLR_axis_source_type,
    buttons, [WLR_POINTER_BUTTONS_CAP] Word32,
    button_count, CSize,
    grab_button, Word32,
    grab_serial, Word32,
    grab_time, Word32,
    surface_destroy, WL_listener,
    events focus_change, WL_signal,
}}

{{ struct
    wlr/types/wlr_seat.h,
    wlr_seat_keyboard_state,
    seat, Ptr WLR_seat,
    keyboard, Ptr WLR_keyboard,
    focused_client, Ptr WLR_seat_client,
    focused_surface, Ptr WLR_surface,
    keyboard_destroy, WL_listener,
    keyboard_keymap, WL_listener,
    keyboard_repeat_info, WL_listener,
    surface_destroy, WL_listener,
    grab, Ptr WLR_seat_keyboard_grab,
    default_grab, Ptr WLR_seat_keyboard_grab,
    events focus_change, WL_signal,
}}

{{ struct
    wlr/types/wlr_seat.h,
    wlr_seat_touch_state,
    seat, Ptr WLR_seat,
    touch_points, WL_list,
    grab_serial, Word32,
    grab_id, Word32,
    grab, Ptr WLR_seat_touch_grab,
    default_grab, Ptr WLR_seat_touch_grab,
}}

{{ struct
    wlr/types/wlr_seat.h,
    wlr_seat,
    global, Ptr WL_global,
    display, Ptr WL_display,
    clients, Ptr WL_list,
    name, CString,
    capabilities, Word32,
    accumulated_capabilities, Word32,
    last_event, TIMESPEC,
    selection_source, Ptr WLR_data_source,
    selection_serial, Word32,
    selection_offers, WL_list,
    primary_selection_source, Ptr WLR_primary_selection_source,
    primary_selection_serial, Word32,
    drag, Ptr WLR_drag,
    drag_source, Ptr WLR_data_source,
    drag_serial, Word32,
    drag_offers, WL_list,
    pointer_state, WLR_seat_pointer_state,
    keyboard_state, WLR_seat_keyboard_state,
    touch_state, WLR_seat_touch_state,
    display_destroy, WL_listener,
    selection_source_destroy, WL_listener,
    primary_selection_source_destroy, WL_listener,
    drag_source_destroy, WL_listener,
    events pointer_grab_begin, WL_signal,
    events pointer_grab_end, WL_signal,
    events keyboard_grab_begin, WL_signal,
    events keyboard_grab_end, WL_signal,
    events touch_grab_begin, WL_signal,
    events touch_grab_end, WL_signal,
    events request_set_cursor, WL_signal,
    events request_set_selection, WL_signal,
    events set_selection, WL_signal,
    events request_set_primary_selection, WL_signal,
    events set_primary_selection, WL_signal,
    events request_start_drag, WL_signal,
    events start_drag, WL_signal,
    events destroy, WL_signal,
    data, Ptr ()
}}

{{ struct
    wlr/types/seat.h,
    wlr_touch_point,
    touch_id, Int32,
    surface, Ptr WLR_surface,
    client, Ptr WLR_seat_client,
    focus_surface, Ptr WLR_surface,
    focus_client, Ptr WLR_seat_client,
    sx, CDouble,
    sy, CDouble,
    surface_destroy, WL_listener,
    focus_surface_destroy, WL_listener,
    client_destroy, WL_listener,
    events destroy, WL_signal,
    link, WL_list
}}

-- TODO interface was a ConstPtr
-- it looks there is a type for this starting in base 4.18.0.0
-- https://hackage.haskell.org/package/base-4.19.0.0/docs/Foreign-C-ConstPtr.html

{{ struct
    wlr/types/wlr_seat.h,
    wlr_seat_keyboard_grab,
    interface, Ptr WLR_keyboard_grab_interface,
    seat, Ptr WLR_seat,
    data, Ptr ()
}}

{{ struct
    wlr/types/wlr_seat.h,
    wlr_keyboard_grab_interface,
    enter, FunPtr (Ptr WLR_seat_keyboard_grab -> Ptr WLR_surface -> [] Word32 -> IO ()),
    clear_focus, FunPtr (Ptr WLR_seat_keyboard_grab -> IO ()),
    key, FunPtr (Ptr WLR_seat_keyboard_grab -> Word32 -> Word32 -> Word32 -> IO ()),
    modifiers, FunPtr (Ptr WLR_seat_keyboard_grab -> Ptr WLR_keyboard_modifiers -> IO ()),
    cancel, FunPtr (Ptr WLR_seat_keyboard_grab -> IO ())
}}

{{ struct
    wlr/types/wlr_seat.h,
    wlr_touch_grab_interface,
    down, FunPtr (Ptr WLR_seat_touch_grab -> Word32 -> Ptr WLR_touch_point -> IO (Word32)),
    up, FunPtr (Ptr WLR_seat_touch_grab -> Word32 -> Ptr WLR_touch_point -> IO ()),
    motion, FunPtr (Ptr WLR_seat_touch_grab -> Word32 -> Ptr WLR_touch_point -> IO ()),
    enter, FunPtr (Ptr WLR_seat_touch_grab -> Word32 -> Ptr WLR_touch_point -> IO ()),
    frame, FunPtr (Ptr WLR_seat_touch_grab -> IO ()),
    cancel, FunPtr (Ptr WLR_seat_touch_grab -> IO()),
    wl_cancel, FunPtr (Ptr WLR_seat_touch_grab -> Ptr WLR_surface -> IO ())
}}

{{ struct
    wlr/types/seat.h,
    wlr_seat_touch_grab,
    interface, Ptr WLR_touch_grab_interface,
    seat, Ptr WLR_seat,
    data, Ptr ()
}}

{{ struct
    wlr/types/seat.h,
    wlr_seat_pointer_request_set_cursor_event,
    seat_client, Ptr WLR_seat_client,
    surface, Ptr WLR_surface,
    serial, Word32,
    hotspot_x, Int32,
    hotspot_y, Int32
}}

{{ struct
    wlr/types/seat.h,
    wlr_seat_request_set_selection_event,
    source, Ptr WLR_data_source,
    serial, Word32
}}

{{ struct wlr/types/seat.h,
    wlr_seat_request_set_primary_selection_event,
    source, Ptr WLR_primary_selection_source,
    serial, Word32
}}

{{ struct wlr/types/seat.h,
    wlr_seat_request_start_drag_event,
    drag, Ptr WLR_drag,
    origin, Ptr WLR_surface,
    serial, Word32
}}

{{ struct wlr/types/seat.h,
    wlr_seat_pointer_focus_change_event,
    seat, Ptr WLR_seat,
    old_surface, Ptr WLR_surface,
    new_surface, Ptr WLR_surface,
    sx, CDouble,
    sy, CDouble
}}
{{ struct wlr/types/seat.h,
    wlr_seat_keyboard_focus_change_event,
    seat, Ptr WLR_seat,
    old_surface, Ptr WLR_surface,
    new_surface, Ptr WLR_surface,
}}

{-
 - Allocates a new struct wlr_seat and adds a wl_seat global to the display.
 -}
foreign import capi "wlr/types/wlr_seat.h wlr_seat_create"
    wlr_seat_create :: Ptr WL_display -> CString -> IO (Ptr WLR_seat)

{-
 - Destroys a seat, removes its wl_seat global and clears focus for all
 - devices belonging to the seat.
 -}
foreign import capi "wlr/types/wlr_seat.h wlr_seat_destroy"
    wlr_seat_destroy :: Ptr WLR_seat -> IO ()

{-
 - Gets a struct wlr_seat_client for the specified client, or returns NULL if no
 - client is bound for that client.
 -}
foreign import capi "wlr/types/wlr_seat.h wlr_seat_client_for_wl_client"
    wlr_seat_client_for_wl_client :: Ptr WLR_seat -> Ptr WL_client -> IO (Ptr WLR_seat_client)

{-
 - Updates the capabilities available on this seat.
 - Will automatically send them to all clients.
 -}
foreign import capi "wlr/types/wlr_seat.h wlr_seat_set_capabilities"
    wlr_seat_set_capabilities :: Ptr WLR_seat -> Word32 -> IO ()

--wlr_seat_set_name
{-
 - Updates the name of this seat.
 - Will automatically send it to all clients.
 -}
foreign import capi "wlr/types/wlr_seat.h wlr_seat_set_name"
    wlr_seat_set_name :: Ptr WLR_seat -> CString -> IO ()

{-
 - Whether or not the surface has pointer focus
 -}
foreign import capi "wlr/types/wlr_seat.h wlr_seat_pointer_surface_has_focus"
    wlr_seat_pointer_surface_has_focus :: Ptr WLR_seat -> Ptr WLR_surface -> IO CBool

{-
 - Send a pointer enter event to the given surface and consider it to be the
 - focused surface for the pointer. This will send a leave event to the last
 - surface that was entered. Coordinates for the enter event are surface-local.
 - This function does not respect pointer grabs: you probably want
 - wlr_seat_pointer_notify_enter() instead.
 -}
foreign import capi "wlr/types/wlr_seat.h wlr_seat_pointer_enter"
    wlr_seat_pointer_enter :: Ptr WLR_seat -> Ptr WLR_surface -> CDouble -> CDouble -> IO ()

{-
 - Clear the focused surface for the pointer and leave all entered surfaces.
 - This function does not respect pointer grabs: you probably want
 - wlr_seat_pointer_notify_clear_focus() instead.
 -}
foreign import capi "wlr/types/wlr_seat.h wlr_seat_pointer_clear_focus"
    wlr_seat_pointer_clear_focus :: Ptr WLR_seat -> IO ()

{-
 - Send a motion event to the surface with pointer focus. Coordinates for the
 - motion event are surface-local. This function does not respect pointer grabs:
 - you probably want wlr_seat_pointer_notify_motion() instead.
 -}
foreign import capi "wlr/types/wlr_seat.h wlr_seat_pointer_send_motion"
    wlr_seat_pointer_send_motion :: Ptr WLR_seat -> Word32 -> CDouble -> CDouble -> IO ()

{-
 - Send a button event to the surface with pointer focus. Coordinates for the
 - button event are surface-local. Returns the serial. This function does not
 - respect pointer grabs: you probably want wlr_seat_pointer_notify_button()
 - instead.
 -}
foreign import capi "wlr/types/wlr_seat.h wlr_seat_pointer_send_button"
    wlr_seat_pointer_send_button :: Ptr WLR_seat -> Word32 -> Word32 -> WLR_button_state_type -> IO Word32

{-
 - Send an axis event to the surface with pointer focus. This function does not
 - respect pointer grabs: you probably want wlr_seat_pointer_notify_axis()
 - instead.
 -}
foreign import capi "wlr/types/wlr_seat.h wlr_seat_pointer_send_axis"
    wlr_seat_pointer_send_axis :: Ptr WLR_seat -> Word32 -> WLR_axis_orientation_type -> CDouble -> Int32 -> WLR_axis_source_type -> IO ()

{-
 - Send a frame event to the surface with pointer focus. This function does not
 - respect pointer grabs: you probably want wlr_seat_pointer_notify_frame()
 - instead.
 -}
foreign import capi "wlr/types/wlr_seat.h wlr_seat_pointer_send_frame"
    wlr_seat_pointer_send_frame :: Ptr WLR_seat -> IO ()

{-
 - Notify the seat of a pointer enter event to the given surface and request it
 - to be the focused surface for the pointer. Pass surface-local coordinates
 - where the enter occurred. This will send a leave event to the currently-
 - focused surface. Defers to any grab of the pointer.
 -}
foreign import capi "wlr/types/wlr_seat.h wlr_seat_pointer_notify_enter"
    wlr_seat_pointer_notify_enter :: Ptr WLR_seat -> Ptr WLR_surface -> CDouble -> CDouble -> IO ()

{-
 - Notify the seat of a pointer leave event to the currently-focused surface.
 - Defers to any grab of the pointer.
 -}
foreign import capi "wlr/types/wlr_seat.h wlr_seat_pointer_notify_clear_focus"
    wlr_seat_pointer_notify_clear_focus :: Ptr WLR_seat -> IO ()

{-
 - Warp the pointer of this seat to the given surface-local coordinates, without
 - generating motion events.
 -}
foreign import capi "wlr/types/wlr_seat.h wlr_seat_pointer_warp"
    wlr_seat_pointer_warp :: Ptr WLR_seat -> CDouble -> CDouble -> IO ()

{-
 - Notify the seat of motion over the given surface. Pass surface-local
 - coordinates where the pointer motion occurred. Defers to any grab of the
 - pointer.
 -}
foreign import capi "wlr/types/wlr_seat.h wlr_seat_pointer_notify_motion"
    wlr_seat_pointer_notify_motion :: Ptr WLR_seat -> Word32 -> CDouble -> CDouble -> IO ()

{-
 - Notify the seat that a button has been pressed. Returns the serial of the
 - button press or zero if no button press was sent. Defers to any grab of the
 - pointer.
 -}
foreign import capi "wlr/types/wlr_seat.h wlr_seat_pointer_notify_button"
    wlr_seat_pointer_notify_button :: Ptr WLR_seat -> Word32 -> Word32 -> WLR_button_state_type -> IO Word32
