{-# LANGUAGE EmptyDataDeriving #-}
module WLR.Util.Box where

#include <wlr/util/box.h>

import Foreign
import Foreign.C.Types

data {-# CTYPE "wlr/util/box.h" "struct wlr_box" #-} WLR_box
    = WLR_box
    { wlr_box_x :: CInt
    , wlr_box_y :: CInt
    , wlr_box_width :: CInt
    , wlr_box_height :: CInt
    } deriving (Show)

instance Storable WLR_box where
    alignment _ = #alignment struct wlr_box
    sizeOf _ = #size struct wlr_box
    peek ptr = WLR_box
        <$> (#peek struct wlr_box, x) ptr
        <*> (#peek struct wlr_box, y) ptr
        <*> (#peek struct wlr_box, width) ptr
        <*> (#peek struct wlr_box, height) ptr
    poke ptr t = do
        (#poke struct wlr_box, x) ptr $ wlr_box_x t
        (#poke struct wlr_box, y) ptr $ wlr_box_y t
        (#poke struct wlr_box, width) ptr $ wlr_box_width t
        (#poke struct wlr_box, height) ptr $ wlr_box_height t

data {-# CTYPE "wlr/util/box.h" "struct wlr_fbox" #-} WLR_fbox
    = WLR_fbox
    { wlr_fbox_x :: CDouble
    , wlr_fbox_y :: CDouble
    , wlr_fbox_width :: CDouble
    , wlr_fbox_height :: CDouble
    } deriving (Show)

instance Storable WLR_fbox where
    alignment _ = #alignment struct wlr_fbox
    sizeOf _ = #size struct wlr_fbox
    peek ptr = WLR_fbox
        <$> (#peek struct wlr_fbox, x) ptr
        <*> (#peek struct wlr_fbox, y) ptr
        <*> (#peek struct wlr_fbox, width) ptr
        <*> (#peek struct wlr_fbox, height) ptr
    poke ptr t = do
        (#poke struct wlr_fbox, x) ptr $ wlr_fbox_x t
        (#poke struct wlr_fbox, y) ptr $ wlr_fbox_y t
        (#poke struct wlr_fbox, width) ptr $ wlr_fbox_width t
        (#poke struct wlr_fbox, height) ptr $ wlr_fbox_height t
