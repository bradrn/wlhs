module WLR.Types.PrimarySelection where

#define WLR_USE_UNSTABLE
#include <wlr/types/wlr_primary_selection.h>

import Foreign.Ptr (Ptr)
import Foreign.Storable (Storable(..))

import WL.Utils (WL_array)
import WL.ServerCore (WL_signal)

{{ struct wlr/types/wlr_primary_selection.h, wlr_primary_selection_source_impl }}

{{ struct
    wlr/types/wlr_primary_selection.h,
    wlr_primary_selection_source,
    impl, Ptr WLR_primary_selection_source_impl,
    mime_types, WL_array,
    events destroy, WL_signal,
    data, Ptr ()
}}
