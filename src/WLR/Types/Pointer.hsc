module WLR.Types.Pointer (
    ) where

#define WLR_USE_UNSTABLE
#include <wlr/types/wlr_pointer.h>

data {-# CTYPE "wlr/types/wlr_pointer.h" "struct wlr_pointer_impl" #-} WLR_pointer_impl
    deriving (Show)

data {-# CTYPE "wlr/types/wlr_pointer.h" "struct wlr_pointer" #-} WLR_pointer
    = WLR_pointer
    { wlr_pointer_base :: Ptr WLR_input_device
    , wlr_pointer_impl :: Ptr WLR_pointer_impl
    , wlr_pointer_output_name :: Ptr CString
    --, wlr_pointer_events :: WLR_pointer_events 
    }

--	char *output_name;
--
--	struct {
--		struct wl_signal motion; // struct wlr_pointer_motion_event
--		struct wl_signal motion_absolute; // struct wlr_pointer_motion_absolute_event
--		struct wl_signal button; // struct wlr_pointer_button_event
--		struct wl_signal axis; // struct wlr_pointer_axis_event
--		struct wl_signal frame;
--
--		struct wl_signal swipe_begin; // struct wlr_pointer_swipe_begin_event
--		struct wl_signal swipe_update; // struct wlr_pointer_swipe_update_event
--		struct wl_signal swipe_end; // struct wlr_pointer_swipe_end_event
--
--		struct wl_signal pinch_begin; // struct wlr_pointer_pinch_begin_event
--		struct wl_signal pinch_update; // struct wlr_pointer_pinch_update_event
--		struct wl_signal pinch_end; // struct wlr_pointer_pinch_end_event
--
--		struct wl_signal hold_begin; // struct wlr_pointer_hold_begin_event
--		struct wl_signal hold_end; // struct wlr_pointer_hold_end_event
--	} events;
--
--	void *data;
--};
