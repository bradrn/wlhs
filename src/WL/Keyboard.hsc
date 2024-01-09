{-# LANGUAGE PatternSynonyms #-}
module WL.Keyboard where

import Foreign.C.Types (CInt)

-- still not sure I like any CInt working in place of a WL_keyboard_key_state
type WL_keyboard_key_state = CInt

-- not pressed
pattern WL_KEYBOARD_KEY_STATE_RELEASED :: (Eq a, Num a) => a
pattern WL_KEYBOARD_KEY_STATE_RELEASED = 0
-- pressed
pattern WL_KEYBOARD_KEY_STATE_PRESSED :: (Eq a, Num a) => a
pattern WL_KEYBOARD_KEY_STATE_PRESSED = 1
