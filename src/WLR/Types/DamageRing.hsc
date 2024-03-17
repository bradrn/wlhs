{-# LANGUAGE PatternSynonyms #-}
module WLR.Types.DamageRing where

#define WLR_USE_UNSTABLE
#include <wlr/types/wlr_damage_ring.h>

import Foreign.Ptr (Ptr, plusPtr)
import Foreign (Storable(..), Int32, peekArray, pokeArray)
import Foreign.C.Types (CInt(..), CBool(..), CSize)

import WLR.Util.Box (WLR_box)
import PIXMAN.Pixman (PIXMAN_region32)

-- | For triple buffering, a history of two frames is required.
pattern WLR_DAMAGE_RING_PREVIOUS_LEN :: (Eq a, Num a) => a
pattern WLR_DAMAGE_RING_PREVIOUS_LEN = 2

-- | current - Difference between the current buffer and the previous one
-- | previous and previous_idx are private state
{{ struct wlr/types/wlr_damage_ring.h,
    wlr_damage_ring,
    width, Int32,
    height, Int32,
    current, PIXMAN_region32,
    previous, [WLR_DAMAGE_RING_PREVIOUS_LEN] PIXMAN_region32,
    previous_idx, CSize
}}

foreign import capi "wlr/types/wlr_damage_ring.h wlr_damage_ring_init"
    wlr_damage_ring_init :: Ptr WLR_damage_ring -> IO ()

foreign import capi "wlr/types/wlr_damage_ring.h wlr_damage_ring_finish"
    wlr_damage_ring_finish :: Ptr WLR_damage_ring -> IO ()

{- |
 - ring -> width -> height -> void
 - Set ring bounds and damage the ring fully.
 -
 - Next time damage will be added, it will be cropped to the ring bounds.
 - If at least one of the dimensions is 0, bounds are removed.
 -
 - By default, a damage ring doesn't have bounds.
 -}
foreign import capi "wlr/types/wlr_damage_ring.h wlr_damage_ring_set_bounds"
    wlr_damage_ring_set_bounds :: Ptr WLR_damage_ring -> Int32 -> Int32 -> IO ()

{- |
 - Add a region to the current damage.
 -
 - Returns true if the region intersects the ring bounds, false otherwise.
 -}
foreign import capi "wlr/types/wlr_damage_ring.h wlr_damage_ring_add"
    wlr_damage_ring_add :: Ptr WLR_damage_ring -> Ptr PIXMAN_region32 -> IO (CBool)

{- |
 - Add a box to the current damage.
 -
 - Returns true if the box intersects the ring bounds, false otherwise.
 -}
foreign import capi "wlr/types/wlr_damage_ring.h wlr_damage_ring_add_box"
    wlr_damage_ring_add_box :: Ptr WLR_damage_ring -> Ptr WLR_box -> IO (CBool)

{-
 - Damage the ring fully.
 -}
foreign import capi "wlr/types/wlr_damage_ring.h wlr_damage_ring_add_whole"
    wlr_damage_ring_add_whole :: Ptr WLR_damage_ring -> IO ()

{-
 - Rotate the damage ring. This needs to be called after using the accumulated
 - damage, e.g. after rendering to an output's back buffer.
 -}
foreign import capi "wlr/types/wlr_damage_ring.h wlr_damage_ring_rotate"
    wlr_damage_ring_rotate :: Ptr WLR_damage_ring -> IO ()

{-
 - Get accumulated damage, which is the difference between the current buffer
 - and the buffer with age of buffer_age; in context of rendering, this is
 - the region that needs to be redrawn.
 -}
foreign import capi "wlr/types/wlr_damage_ring.h wlr_damage_ring_get_buffer_damage"
    wlr_damage_ring_get_buffer_damage :: Ptr WLR_damage_ring -> CInt -> Ptr PIXMAN_region32 -> IO ()
