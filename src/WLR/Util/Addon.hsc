module WLR.Util.Addon where

#define WLR_USE_UNSTABLE
#include <wlr/util/addon.h>

import Foreign
import Foreign.C.Types

import WL.Utils

newtype {-# CTYPE "wlr/util/wlr_addon.h" "struct wlr_addon_set" #-} WLR_addon_set
    = WLR_addon_set
    { -- | private state
      wlr_addon_set_addons :: WL_list
    } deriving (Show)

instance Storable WLR_addon_set where
    alignment _ = #alignment struct wlr_addon_set
    sizeOf _ = #size struct wlr_addon_set
    peek ptr = WLR_addon_set <$> (#peek struct wlr_addon_set, addons) ptr
    poke ptr t = (#poke struct wlr_addon_set, addons) ptr $ wlr_addon_set_addons t
