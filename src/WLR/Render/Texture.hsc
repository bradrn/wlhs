{-# LANGUAGE EmptyDataDeriving, PatternSynonyms #-}

module WLR.Render.Texture where

#define WLR_USE_UNSTABLE
-- Include the interface header, which in turn includes the desired
-- <wlr/render/wlr_texture.h>. This makes it possible to define
-- WLR_texture_impl in this file, avoiding recursive imports
#include <wlr/render/interface.h>

import Foreign
import Foreign.C.Types

import PIXMAN.Pixman
import WLR.Render.Renderer
import WLR.Types.Buffer

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

{{ struct
    wlr/render/interface.h,
    wlr_texture_impl,
    update_from_buffer, FunPtr FunUpdateFromBuffer,
    destroy,            FunPtr (Ptr WLR_texture -> IO ())
}}
