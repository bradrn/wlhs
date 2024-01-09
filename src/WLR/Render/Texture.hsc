{-# LANGUAGE EmptyDataDeriving #-}
module WLR.Render.Texture where
import WLR.Render.Renderer (WLR_renderer)

import Foreign.C.Types (CUInt)
import Foreign.Ptr (Ptr)
import Foreign.Storable (Storable(..))

#define WLR_USE_UNSTABLE
#include <wlr/render/wlr_texture.h>

{{ struct
    wlr/render/wlr_texture.h,
    wlr_texture_impl
}}

{{ struct
    wlr/render/wlr_texture.h,
    wlr_texture,
    impl, Ptr WLR_texture_impl,
    width, CUInt,
    height, CUInt,
    renderer, Ptr WLR_renderer
}}
