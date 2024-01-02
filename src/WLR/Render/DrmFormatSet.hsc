module WLR.Render.DrmFormatSet where

#define WLR_USE_UNSTABLE
#include <wlr/render/drm_format_set.h>

import Foreign
import Foreign.C.Types

data {-# CTYPE "wlr/renderer/drm_format_set.h" "struct wlr_drm_format" #-} WLR_drm_format
    = WLR_drm_format
    { wlr_drm_format_format :: Word32
    , wlr_drm_format_len :: CSize
    -- | do not use
    , wlr_drm_format_capacity :: CSize
    , wlr_drm_format_modifiers :: Ptr Word64
    } deriving (Show)

instance Storable WLR_drm_format where
    alignment _ = #alignment struct wlr_drm_format
    sizeOf _ = #size struct wlr_drm_format
    peek ptr = WLR_drm_format
        <$> (#peek struct wlr_drm_format, format) ptr
        <*> (#peek struct wlr_drm_format, len) ptr
        <*> (#peek struct wlr_drm_format, capacity) ptr
        <*> (#peek struct wlr_drm_format, modifiers) ptr
    poke ptr t = do
        (#poke struct wlr_drm_format, format) ptr $ wlr_drm_format_format t
        (#poke struct wlr_drm_format, len) ptr $ wlr_drm_format_len t
        (#poke struct wlr_drm_format, capacity) ptr $ wlr_drm_format_capacity t
        (#poke struct wlr_drm_format, modifiers) ptr $ wlr_drm_format_modifiers t
