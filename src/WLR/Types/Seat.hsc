module WLR.Types.Seat where

#include <time.h>

#define WLR_USE_UNSTABLE
#include <wlr/types/wlr_seat.h>

import Foreign.C.String (CString)
import Foreign.C.Types (CUInt, CDouble, CInt, CBool)
-- if we upgrade our base libraries we can use this
-- https://github.com/haskell/core-libraries-committee/issues/118
-- import Foreign.C.ConstPtr
import Foreign.Ptr (Ptr, FunPtr)
import Foreign.Storable (Storable(..))

import WL.ServerProtocol (WL_display)
import WL.ServerCore (WL_signal, WL_listener)
import WL.Global (WL_global)
import WL.Client (WL_client)
import WL.Utils (WL_list)

--import {-# SOURCE #-} WLR.Types.DataDevice (WLR_drag, WLR_data_source)
import WLR.Types.PrimarySelection (WLR_primary_selection_source)
import WLR.Types.Compositor (WLR_surface)

type TODOArray = Ptr ()

{{ struct
    wlr/types/wlr_seat.h,
    wlr_serial_range,
    min_incl, CUInt,
    max_incl, CUInt
}}

{{ struct
    wlr/types/wlr_seat.h,
    wlr_serial_ringset,
    data, TODOArray,
    end, CInt,
    count, CInt
}}

-- TODO arrays
--struct {
--    int32_t acc_discrete[2];
--    int32_t last_discrete[2];
--    double acc_axis[2];
--} value120;
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
    value120 acc_discrete, TODOArray,
    value120 last_discrete, TODOArray,
    value120 acc_axis, TODOArray,
}}

{{ struct
    wlr/types/wlr_seat.h,
    wlr_seat_pointer_grab,
    interface, Ptr wlr_pointer_grab_interface,
    seat, Ptr WLR_seat,
    data, Ptr ()
}}

-- TODO array type uint32_t buttons[WLR_POINTER_BUTTONS_CAP];
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
    cached_axis_source, WLR_axis_source,
    buttons, TODOArray,
    button_count, CSize,
    grab_button, CUInt,
    grab_serial, CUInt,
    grab_time, CUInt,
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
    grab_serial, CUInt,
    grab_id, CUInt,
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
    capabilities, CUInt,
    accumulated_capabilities, CUInt,
    last_event, timespec,
    selection_source, Ptr WLR_data_source,
    selection_serial, CUInt,
    selection_offers, WL_list,
    primary_selection_source, Ptr WLR_primary_selection_source,
    primary_selection_serial, CUInt,
    drag, Ptr WLR_drag,
    drag_source, Ptr WLR_data_source,
    drag_serial, CUInt,
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

-- TODO interface was a ConstPtr

{{ struct
    wlr/types/wlr_seat.h,
    wlr_seat_keyboard_grab,
    interface, Ptr WLR_keyboard_grab_interface,
    seat, Ptr WLR_seat,
    data, Ptr ()
}}

-- TODO enter's CUInt final parameter is a const array

{{ struct
    wlr/types/wlr_seat.h,
    wlr_keyboard_grab_interface,
    enter, FunPtr (Ptr WLR_seat_keyboard_grab -> Ptr WLR_surface -> CUInt -> IO ()),
    clear_focus, FunPtr (Ptr WLR_seat_keyboard_grab -> IO ()),
    key, FunPtr (Ptr WLR_seat_keyboard_grab -> CUInt -> CUInt -> CUInt -> IO ()),
    modifiers, FunPtr (Ptr WLR_seat_keyboard_grab -> Ptr WLR_keyboard_modifiers -> IO ()),
    cancel, FunPtr (Ptr WLR_seat_keyboard_grab -> IO ())
}}
