{-# LANGUAGE PatternSynonyms #-}
module WL.Keyboard where

#include <wayland-server-protocol.h>

import Foreign.C.Types (CInt)

{{
    enum
    WL_keyboard_key_state,
    WL_KEYBOARD_KEY_STATE_RELEASED,
    WL_KEYBOARD_KEY_STATE_PRESSED
}}
