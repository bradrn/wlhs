{-# LANGUAGE EmptyDataDeriving #-}
module WLR.Types.Pointer (
    ) where

#define WLR_USE_UNSTABLE
#include <wlr/types/wlr_pointer.h>

import Foreign.Ptr (
    Ptr
    )
import Foreign.C.String (
    CString
    )
import Foreign.Storable (
    Storable(..)
    )

import WLR.Types.InputDevice (
    WLR_input_device
    )
import WL.ServerCore (
    WL_signal
    )

data {-# CTYPE "wlr/types/wlr_pointer.h" "struct wlr_pointer_impl" #-} WLR_pointer_impl
    deriving (Show)

data Wlr_pointer_data

data {-# CTYPE "wlr/types/wlr_pointer.h" "struct wlr_pointer" #-} WLR_pointer
    = WLR_pointer
    { wlr_pointer_base :: Ptr WLR_input_device
    , wlr_pointer_impl :: Ptr WLR_pointer_impl
    , wlr_pointer_output_name :: Ptr CString
    , wlr_pointer_events :: WLR_pointer_events

    -- TODO what type is this? It's a void* in the C source
    -- void *data;
    , wlr_pointer_data :: Ptr Wlr_pointer_data
    }

instance Storable WLR_pointer where
    alignment _ = #alignment struct wlr_pointer
    sizeOf _ = #size struct wlr_pointer
    peek ptr = WLR_pointer
        <$> (#peek struct wlr_pointer, base) ptr
        <*> (#peek struct wlr_pointer, impl) ptr
        <*> (#peek struct wlr_pointer, output_name) ptr
        <*> (#peek struct wlr_pointer, events) ptr
        <*> (#peek struct wlr_pointer, data) ptr

{-# 
 - TODO there were some source comments here that had some sort of struct
 - type specified, I guess it's a hint about the types???
 - I think I did the comment structure so that `struct wlr_pointer_motion_event` will show on hover
 - need to check that when I get my hls working ~ Matt
#-}
data WLR_pointer_events = WLR_pointer_events {
    -- |struct wlr_pointer_motion_event
    wlr_pointer_events_motion :: WL_signal
    -- |struct wlr_pointer_motion_absolute_event
    , wlr_pointer_events_motion_absolute :: WL_signal
    -- |struct wlr_pointer_button_event
    , wlr_pointer_events_button :: WL_signal
    -- |struct wlr_pointer_axis_event
    , wlr_pointer_events_axis :: WL_signal
    , wlr_pointer_events_frame

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
    }
