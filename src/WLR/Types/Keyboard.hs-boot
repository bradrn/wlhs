-- there is an import cycle in the C: wlr_keyboard <-> wlr_keyboard_group
-- so I either needed to move all of the keyboard group definitions into the
-- Keyboard.hsc file (yuck), or declare an hs-boot file for Keyboard and
-- use the SOURCE pragma when keyboard group imports it
-- I chose the latter, because other work arounds would be less similar to the C source
module WLR.Types.Keyboard where
   data WLR_keyboard
