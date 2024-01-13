module WLR.Util.Addon where

#define WLR_USE_UNSTABLE
#include <wlr/util/addon.h>

import Foreign

import WL.Utils

{{ struct
    wlr/util/wlr_addon.h,
    wlr_addon_set,
    addons, WL_list
}}
