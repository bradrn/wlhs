{-# LANGUAGE EmptyDataDeriving, PatternSynonyms #-}

module WLR.Render.Texture where

#define WLR_USE_UNSTABLE
#include <wlr/render/wlr_texture.h>

import Foreign
import Foreign.C.Types

import PIXMAN.Pixman
import WLR.Render.Renderer
import WLR.Types.Buffer
import {-# SOURCE #-} WLR.Render.Interface (WLR_texture_impl)

{{ struct
    wlr/render/wlr_texture.h,
    wlr_texture,
    impl,     Ptr WLR_texture_impl,
    width,    Word32,
    height,   Word32,
    renderer, Ptr WLR_renderer
}}

type FunUpdateFromBuffer
    =  Ptr WLR_texture
    -> Ptr WLR_buffer
    -> Ptr PIXMAN_region32_t
    -> IO (CBool)
