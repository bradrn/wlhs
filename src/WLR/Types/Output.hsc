{-# LANGUAGE EmptyDataDeriving, PatternSynonyms #-}

module WLR.Types.Output where

#define WLR_USE_UNSTABLE
#include <wlr/types/wlr_output.h>

import Foreign
import Foreign.C.Types

import PIXMAN.Pixman
import WL.ServerCore
import WL.ServerProtocol
import WL.Utils
import WLR.Backend
import WLR.Render.Allocator
import WLR.Render.DrmFormatSet
import WLR.Render.Interface
import WLR.Render.Renderer
import WLR.Render.Swapchain
import WLR.Render.Texture
import WLR.Types.Buffer
import WLR.Types.OutputLayer
import WLR.Util.Addon
import WLR.Util.Box

-- A struct from <time.h>. I think this should only be handled by
-- standard library code, so an opaque pointer should suffice.
type TIMESPEC = ()

{{ enum
    WLR_output_mode_aspect_ratio,
    WLR_OUTPUT_MODE_ASPECT_RATIO_NONE,
    WLR_OUTPUT_MODE_ASPECT_RATIO_4_3,
    WLR_OUTPUT_MODE_ASPECT_RATIO_16_9,
    WLR_OUTPUT_MODE_ASPECT_RATIO_64_27,
    WLR_OUTPUT_MODE_ASPECT_RATIO_256_135
}}

{{ struct
    wlr/types/wlr_output.h,
    wlr_output_mode,
    width,                CInt,
    height,               CInt,
    refresh,              CInt,
    preferred,            CBool,
    picture_aspect_ratio, WLR_output_mode_aspect_ratio,
    link,                 WL_list
}}

{{ struct
    wlr/types/wlr_output.h,
    wlr_output_cursor,
    output,      Ptr WLR_output,
    x,           CDouble,
    y,           CDouble,
    enabled,     CBool,
    visible,     CBool,
    width,       CUInt,
    height,      CUInt,
    src_box,     WLR_fbox,
    transform,   WL_output_transform,
    hotspot_x,   CInt,
    hotspot_y,   CInt,
    texture,     Ptr WLR_texture,
    own_texture, CBool,
    link,        WL_list
}}

{{ enum
    WLR_output_adaptive_sync_status,
    WLR_OUTPUT_ADAPTIVE_SYNC_DISABLED,
    WLR_OUTPUT_ADAPTIVE_SYNC_ENABLED
}}

{{ enum
    WLR_output_state_field,
    WLR_OUTPUT_STATE_BUFFER,
    WLR_OUTPUT_STATE_DAMAGE,
    WLR_OUTPUT_STATE_MODE,
    WLR_OUTPUT_STATE_ENABLED,
    WLR_OUTPUT_STATE_SCALE,
    WLR_OUTPUT_STATE_TRANSFORM,
    WLR_OUTPUT_STATE_ADAPTIVE_SYNC_ENABLED,
    WLR_OUTPUT_STATE_GAMMA_LUT,
    WLR_OUTPUT_STATE_RENDER_FORMAT,
    WLR_OUTPUT_STATE_SUBPIXEL,
    WLR_OUTPUT_STATE_LAYERS
}}

{{ enum
    WLR_output_state_mode_type,
    WLR_OUTPUT_STATE_MODE_FIXED,
    WLR_OUTPUT_STATE_MODE_CUSTOM
}}

{{ struct
    wlr/types/wlr_output.h,
    wlr_output_state,
    committed,             CUInt,
    allow_reconfiguration, CBool,
    damage,                PIXMAN_region32_t,
    enabled,               CBool,
    scale,                 CFloat,
    transform,             WL_output_transform,
    adaptive_sync_enabled, CBool,
    render_format,         CUInt,
    subpixel,              WL_output_subpixel,
    buffer,                Ptr WLR_buffer,
    tearing_page_flip,     CBool,
    mode_type,             WLR_output_state_mode_type,
    mode,                  Ptr WLR_output_mode,
    custom_mode width,     CInt,
    custom_mode height,    CInt,
    custom_mode refresh,   CInt,
    gamma_lut,             Ptr CShort,
    gamma_lut_size,        CSize,
    layers,                Ptr WLR_output_layer_state,
    layers_len,            CSize
}}

{{ struct
    wlr/types/wlr_output.h,
    wlr_output_impl
}}

{{ struct
    wlr/types/wlr_output.h,
    wlr_render_pass
}}

{{ struct
    wlr/types/wlr_output.h,
    wlr_output,
    impl,                  Ptr WLR_output_impl,
    backend,               Ptr WLR_backend,
    display,               Ptr WL_display,
    global,                Ptr WL_global,
    resources,             WL_list,
    name,                  Ptr CChar,
    description,           Ptr CChar,
    make,                  Ptr CChar,
    model,                 Ptr CChar,
    serial,                Ptr CChar,
    phys_width,            CInt,
    phys_height,           CInt,
    modes,                 WL_list,
    current_mode,          Ptr WLR_output_mode,
    width,                 CInt,
    height,                CInt,
    refresh,               CInt,
    enabled,               CBool,
    scale,                 CFloat,
    subpixel,              WL_output_subpixel,
    transform,             WL_output_transform,
    adaptive_sync_status,  WLR_output_adaptive_sync_status,
    render_format,         CUInt,
    needs_frame,           CBool,
    frame_pending,         CBool,
    transform_matrix,      [9]CFloat,
    non_desktop,           CBool,
    pending,               WLR_output_state,
    commit_seq,            CUInt,
    events frame,          WL_signal,
    events damage,         WL_signal,
    events needs_frame,    WL_signal,
    events precommit,      WL_signal,
    events commit,         WL_signal,
    events present,        WL_signal,
    events bind,           WL_signal,
    events description,    WL_signal,
    events request_state,  WL_signal,
    events destroy,        WL_signal,
    idle_frame,            Ptr WL_event_source,
    idle_done,             Ptr WL_event_source,
    attach_render_locks,   CInt,
    cursors,               WL_list,
    hardware_cursor,       Ptr WLR_output_cursor,
    cursor_swapchain,      Ptr WLR_swapchain,
    cursor_front_buffer,   Ptr WLR_buffer,
    software_cursor_locks, CInt,
    layers,                WL_list,
    allocator,             Ptr WLR_allocator,
    renderer,              Ptr WLR_renderer,
    swapchain,             Ptr WLR_swapchain,
    back_buffer,           Ptr WLR_buffer,
    display_destroy,       WL_listener,
    addons,                WLR_addon_set,
    data,                  Ptr ()
}}

{{ struct
    wlr/types/wlr_output.h,
    wlr_output_event_damage,
    output, Ptr WLR_output,
    damage, Ptr PIXMAN_region32_t
}}


{{ struct
    wlr/types/wlr_output.h,
    wlr_output_event_precommit,
    output, Ptr WLR_output,
    when,   Ptr TIMESPEC,
    state,  Ptr WLR_output_state
}}

{{ struct
    wlr/types/wlr_output.h,
    wlr_output_event_commit,
    output, Ptr WLR_output,
    when,   Ptr TIMESPEC,
    state,  Ptr WLR_output_state,
}}

{{ enum
    WLR_output_present_flag,
    WLR_OUTPUT_PRESENT_VSYNC,
    WLR_OUTPUT_PRESENT_HW_CLOCK,
    WLR_OUTPUT_PRESENT_HW_COMPLETION,
    WLR_OUTPUT_PRESENT_ZERO_COPY
}}

{{ struct
    wlr/types/wlr_output.h,
    wlr_output_event_present,
    output,     Ptr WLR_output,
    commit_seq, CUInt,
    presented,  CBool,
    when,       Ptr TIMESPEC,
    seq,        CUInt,
    refresh,    CInt,
    flags,      CUInt
}}

{{ struct
    wlr/types/wlr_output.h,
    wlr_output_event_bind,
    output,   Ptr WLR_output,
    resource, Ptr WL_resource
}}

{{ struct
    wlr/types/wlr_output.h,
    wlr_output_event_request_state,
    output, Ptr WLR_output,
    state,  Ptr WLR_output_state
}}

foreign import capi "wlr/types/wlr_output.h wlr_output_enable"
    wlr_output_enable :: Ptr WLR_output -> CBool -> IO ()

foreign import capi "wlr/types/wlr_output.h wlr_output_create_global"
    wlr_output_create_global :: Ptr WLR_output -> IO ()

foreign import capi "wlr/types/wlr_output.h wlr_output_destroy_global"
    wlr_output_destroy_global :: Ptr WLR_output -> IO ()

foreign import capi "wlr/types/wlr_output.h wlr_output_init_render"
    wlr_output_init_render :: Ptr WLR_output -> Ptr WLR_allocator -> Ptr WLR_renderer -> IO (CBool)

foreign import capi "wlr/types/wlr_output.h wlr_output_preferred_mode"
    wlr_output_preferred_mode :: Ptr WLR_output -> IO (Ptr WLR_output_mode)

foreign import capi "wlr/types/wlr_output.h wlr_output_set_mode"
    wlr_output_set_mode :: Ptr WLR_output -> Ptr WLR_output_mode -> IO ()

foreign import capi "wlr/types/wlr_output.h wlr_output_set_custom_mode"
    wlr_output_set_custom_mode :: Ptr WLR_output -> CInt -> CInt -> CInt -> IO ()

foreign import capi "wlr/types/wlr_output.h wlr_output_set_transform"
    wlr_output_set_transform :: Ptr WLR_output -> WL_output_transform -> IO ()

foreign import capi "wlr/types/wlr_output.h wlr_output_enable_adaptive_sync"
    wlr_output_enable_adaptive_sync :: Ptr WLR_output -> CBool -> IO ()

foreign import capi "wlr/types/wlr_output.h wlr_output_set_render_format"
    wlr_output_set_render_format :: Ptr WLR_output -> CUInt -> IO ()

foreign import capi "wlr/types/wlr_output.h wlr_output_set_scale"
    wlr_output_set_scale :: Ptr WLR_output -> CFloat -> IO ()

foreign import capi "wlr/types/wlr_output.h wlr_output_set_subpixel"
    wlr_output_set_subpixel :: Ptr WLR_output -> WL_output_subpixel -> IO ()

foreign import capi "wlr/types/wlr_output.h wlr_output_set_name"
    wlr_output_set_name :: Ptr WLR_output -> Ptr CChar -> IO ()

foreign import capi "wlr/types/wlr_output.h wlr_output_set_description"
    wlr_output_set_description :: Ptr WLR_output -> Ptr CChar -> IO ()

foreign import capi "wlr/types/wlr_output.h wlr_output_schedule_done"
    wlr_output_schedule_done :: Ptr WLR_output -> IO ()

foreign import capi "wlr/types/wlr_output.h wlr_output_destroy"
    wlr_output_destroy :: Ptr WLR_output -> IO ()

foreign import capi "wlr/types/wlr_output.h wlr_output_transformed_resolution"
    wlr_output_transformed_resolution :: Ptr WLR_output -> Ptr CInt -> Ptr CInt -> IO ()

foreign import capi "wlr/types/wlr_output.h wlr_output_effective_resolution"
    wlr_output_effective_resolution :: Ptr WLR_output -> Ptr CInt -> Ptr CInt -> IO ()

foreign import capi "wlr/types/wlr_output.h wlr_output_attach_render"
    wlr_output_attach_render :: Ptr WLR_output -> Ptr CInt -> IO (CBool)

foreign import capi "wlr/types/wlr_output.h wlr_output_attach_buffer"
    wlr_output_attach_buffer :: Ptr WLR_output -> Ptr WLR_buffer -> IO ()

foreign import capi "wlr/types/wlr_output.h wlr_output_preferred_read_format"
    wlr_output_preferred_read_format :: Ptr WLR_output -> IO (CUInt)
 
foreign import capi "wlr/types/wlr_output.h wlr_output_set_damage"
    wlr_output_set_damage :: Ptr WLR_output -> Ptr PIXMAN_region32_t -> IO ()

foreign import capi "wlr/types/wlr_output.h wlr_output_set_layers"
    wlr_output_set_layers :: Ptr WLR_output -> Ptr WLR_output_layer_state -> CSize -> IO ()

foreign import capi "wlr/types/wlr_output.h wlr_output_test"
    wlr_output_test :: Ptr WLR_output -> IO (CBool)

foreign import capi "wlr/types/wlr_output.h wlr_output_commit"
    wlr_output_commit :: Ptr WLR_output -> IO (CBool)

foreign import capi "wlr/types/wlr_output.h wlr_output_rollback"
    wlr_output_rollback :: Ptr WLR_output -> IO ()

foreign import capi "wlr/types/wlr_output.h wlr_output_test_state"
    wlr_output_test_state :: Ptr WLR_output -> Ptr WLR_output_state -> IO (CBool)

foreign import capi "wlr/types/wlr_output.h wlr_output_commit_state"
    wlr_output_commit_state :: Ptr WLR_output -> Ptr WLR_output_state -> IO (CBool)

foreign import capi "wlr/types/wlr_output.h wlr_output_schedule_frame"
    wlr_output_schedule_frame :: Ptr WLR_output -> IO ()

foreign import capi "wlr/types/wlr_output.h wlr_output_get_gamma_size"
    wlr_output_get_gamma_size :: Ptr WLR_output -> IO (CSize)

foreign import capi "wlr/types/wlr_output.h wlr_output_set_gamma"
    wlr_output_set_gamma :: Ptr WLR_output -> CSize -> Ptr CUShort -> Ptr CUShort -> Ptr CUShort -> IO ()

foreign import capi "wlr/types/wlr_output.h wlr_output_from_resource"
    wlr_output_from_resource :: Ptr WL_resource -> IO (Ptr WLR_output)

foreign import capi "wlr/types/wlr_output.h wlr_output_lock_attach_render"
    wlr_output_lock_attach_render :: Ptr WLR_output -> CBool -> IO ()

foreign import capi "wlr/types/wlr_output.h wlr_output_lock_software_cursors"
    wlr_output_lock_software_cursors :: Ptr WLR_output -> CBool -> IO ()

foreign import capi "wlr/types/wlr_output.h wlr_output_render_software_cursors"
    wlr_output_render_software_cursors :: Ptr WLR_output -> Ptr PIXMAN_region32_t -> IO ()

foreign import capi "wlr/types/wlr_output.h wlr_output_add_software_cursors_to_render_pass"
    wlr_output_add_software_cursors_to_render_pass :: Ptr WLR_output -> Ptr WLR_render_pass -> Ptr PIXMAN_region32_t -> IO ()

foreign import capi "wlr/types/wlr_output.h wlr_output_get_primary_formats"
    wlr_output_get_primary_formats :: Ptr WLR_output -> CUInt -> IO (Ptr WLR_drm_format_set)

foreign import capi "wlr/types/wlr_output.h wlr_output_is_direct_scanout_allowed"
    wlr_output_is_direct_scanout_allowed :: Ptr WLR_output -> IO (CBool)

foreign import capi "wlr/types/wlr_output.h wlr_output_cursor_create"
    wlr_output_cursor_create :: Ptr WLR_output -> IO (Ptr WLR_output_cursor)

foreign import capi "wlr/types/wlr_output.h wlr_output_cursor_set_buffer"
    wlr_output_cursor_set_buffer :: Ptr WLR_output_cursor -> Ptr WLR_buffer -> CInt-> CInt -> IO (CBool)

foreign import capi "wlr/types/wlr_output.h wlr_output_cursor_move"
    wlr_output_cursor_move :: Ptr WLR_output_cursor -> CDouble -> CDouble -> IO (CBool)

foreign import capi "wlr/types/wlr_output.h wlr_output_cursor_destroy"
    wlr_output_cursor_destroy :: Ptr WLR_output_cursor -> IO ()

foreign import capi "wlr/types/wlr_output.h wlr_output_state_init"
    wlr_output_state_init :: Ptr WLR_output_state -> IO ()

foreign import capi "wlr/types/wlr_output.h wlr_output_state_finish"
    wlr_output_state_finish :: Ptr WLR_output_state -> IO ()

foreign import capi "wlr/types/wlr_output.h wlr_output_state_set_enabled"
    wlr_output_state_set_enabled :: Ptr WLR_output_state -> CBool -> IO ()

foreign import capi "wlr/types/wlr_output.h wlr_output_state_set_mode"
    wlr_output_state_set_mode :: Ptr WLR_output_state -> Ptr WLR_output_mode -> IO ()

foreign import capi "wlr/types/wlr_output.h wlr_output_state_set_custom_mode"
    wlr_output_state_set_custom_mode :: Ptr WLR_output_state -> CInt -> CInt -> CInt -> IO ()

foreign import capi "wlr/types/wlr_output.h wlr_output_state_set_scale"
    wlr_output_state_set_scale :: Ptr WLR_output_state -> CFloat -> IO ()

foreign import capi "wlr/types/wlr_output.h wlr_output_state_set_transform"
    wlr_output_state_set_transform :: Ptr WLR_output_state -> WL_output_transform -> IO ()

foreign import capi "wlr/types/wlr_output.h wlr_output_state_set_adaptive_sync_enabled"
    wlr_output_state_set_adaptive_sync_enabled :: Ptr WLR_output_state -> CBool -> IO ()

foreign import capi "wlr/types/wlr_output.h wlr_output_state_set_render_format"
    wlr_output_state_set_render_format :: Ptr WLR_output_state -> CUInt -> IO ()

foreign import capi "wlr/types/wlr_output.h wlr_output_state_set_subpixel"
    wlr_output_state_set_subpixel :: Ptr WLR_output_state -> WL_output_subpixel -> IO ()

foreign import capi "wlr/types/wlr_output.h wlr_output_state_set_buffer"
    wlr_output_state_set_buffer :: Ptr WLR_output_state -> Ptr WLR_buffer -> IO ()

foreign import capi "wlr/types/wlr_output.h wlr_output_state_set_gamma_lut"
    wlr_output_state_set_gamma_lut :: Ptr WLR_output_state -> CSize -> Ptr CUShort -> Ptr CUShort -> Ptr CUShort -> IO (CBool)

foreign import capi "wlr/types/wlr_output.h wlr_output_state_set_damage"
    wlr_output_state_set_damage :: Ptr WLR_output_state -> Ptr PIXMAN_region32_t -> IO ()

foreign import capi "wlr/types/wlr_output.h wlr_output_state_set_layers"
    wlr_output_state_set_layers :: Ptr WLR_output_state -> Ptr WLR_output_layer_state -> CSize -> IO ()

foreign import capi "wlr/types/wlr_output.h wlr_output_state_copy"
    wlr_output_state_copy :: Ptr WLR_output_state -> Ptr WLR_output_state -> IO (CBool)

foreign import capi "wlr/types/wlr_output.h wlr_output_configure_primary_swapchain"
    wlr_output_configure_primary_swapchain :: Ptr WLR_output -> Ptr WLR_output_state -> Ptr (Ptr WLR_swapchain) -> IO (CBool)

foreign import capi "wlr/types/wlr_output.h wlr_output_begin_render_pass"
    wlr_output_begin_render_pass :: Ptr WLR_output -> Ptr WLR_output_state -> Ptr CInt -> Ptr WLR_render_timer -> IO (Ptr WLR_render_pass)

foreign import capi "wlr/types/wlr_output.h wlr_output_transform_invert"
    wlr_output_transform_invert :: WL_output_transform -> IO (WL_output_transform)

foreign import capi "wlr/types/wlr_output.h wlr_output_transform_compose"
    wlr_output_transform_compose :: WL_output_transform -> WL_output_transform -> IO (WL_output_transform)
