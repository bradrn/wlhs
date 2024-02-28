{-# LANGUAGE EmptyDataDeriving, PatternSynonyms #-}

module WLR.Render.Interface where

#define WLR_USE_UNSTABLE
#include <wlr/render/interface.h>

import Foreign
import Foreign.C.Types

import WLR.Render.Texture

{{ struct
    wlr/render/interface.h,
    wlr_texture_impl,
    update_from_buffer, FunPtr FunUpdateFromBuffer,
    destroy,            FunPtr (Ptr WLR_texture -> IO ())
}}

{{ struct
    wlr/render/interface.h,
    wlr_render_timer,
    impl, Ptr WLR_render_timer_impl
}}

{{ struct
    wlr/render/interface.h,
    wlr_render_timer_impl,
    get_duration_ns, FunPtr (WLR_render_timer -> IO CInt),
    destroy,         FunPtr (WLR_render_timer -> IO ())
}}
