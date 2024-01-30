{-# LANGUAGE EmptyDataDeriving, PatternSynonyms #-}

module WLR.Types.KeyboardGroup where

#define WLR_USE_UNSTABLE
#include <wlr/types/wlr_keyboard_group.h>

import Foreign.Ptr (Ptr)
import Foreign.Storable (Storable(..))

import WL.Utils (WL_list)
import WL.ServerCore (WL_signal)
import {-# SOURCE #-} WLR.Types.Keyboard (WLR_keyboard)

-- devices :: WL_list keyboard_group_device.link
-- keys :: WL_list keyboard_group_key.link

-- events enter
{-
 - Sent when a keyboard has entered the group with keys currently
 - pressed that are not pressed by any other keyboard in the group. The
 - data for this signal will be a struct wl_array containing the key
 - codes. This should be used to update the compositor's internal state.
 - Bindings should not be triggered based off of these key codes and
 - they should also not notify any surfaces of the key press.
-}

-- events leave
{-
 - Sent when a keyboard has left the group with keys currently pressed
 - that are not pressed by any other keyboard in the group. The data for
 - this signal will be a struct wl_array containing the key codes. This
 - should be used to update the compositor's internal state. Bindings
 - should not be triggered based off of these key codes. Additionally,
 - surfaces should only be notified if they received a corresponding key
 - press for the key code.
-}
{{ struct
    wlr/types/wlr_keyboard_group.h,
    wlr_keyboard_group,
    keyboard, Ptr WLR_keyboard,
    devices, WL_list,
    keys, WL_list,
    events enter, WL_signal,
    events leave, WL_signal,
    data, Ptr ()
}}

foreign import capi "wlr/types/wlr_keyboard_group.h wlr_keyboard_group_create"
    wlr_keyboard_group_create :: IO (Ptr WLR_keyboard_group)

foreign import capi "wlr/types/wlr_keyboard_group.h wlr_keyboard_group_from_wlr_keyboard"
    wlr_keyboard_group_from_wlr_keyboard :: Ptr WLR_keyboard -> Ptr WLR_keyboard_group

-- TODO I looked at the C code for this function and it looks pure, but I'm not sure if it actually is
-- put it in IO for now
foreign import capi "wlr/types/wlr_keyboard_group.h wlr_keyboard_group_add_keyboard"
    wlr_keyboard_group_add_keyboard :: Ptr WLR_keyboard_group -> Ptr WLR_keyboard -> IO (Bool)

foreign import capi "wlr/types/wlr_keyboard_group.h wlr_keyboard_group_remove_keyboard"
    wlr_keyboard_group_remove_keyboard :: Ptr WLR_keyboard_group -> Ptr WLR_keyboard -> IO ()

foreign import capi "wlr/types/wlr_keyboard_group.h wlr_keyboard_group_destroy"
    wlr_keyboard_group_destroy :: Ptr WLR_keyboard_group -> IO ()
