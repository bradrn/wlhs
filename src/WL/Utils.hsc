module WL.Utils where

#include <wayland-util.h>

import Foreign
import Foreign.C.Types
import Foreign.C.String (CString)

{{ struct
    wayland-util.h,
    wl_list,
    prev, Ptr WL_list,
    next, Ptr WL_list
}}

foreign import capi "wayland-util.h wl_list_init"
    wl_list_init :: Ptr WL_list -> IO ()

foreign import capi "wayland-util.h wl_list_insert"
    wl_list_insert :: Ptr WL_list -> Ptr WL_list -> IO ()

foreign import capi "wayland-util.h wl_list_remove"
    wl_list_remove :: Ptr WL_list -> IO ()

foreign import capi "wayland-util.h wl_list_length"
    wl_list_length :: Ptr WL_list -> IO CInt

foreign import capi "wayland-util.h wl_list_empty"
    wl_list_empty :: Ptr WL_list -> IO CInt

{{ struct
    wayland-util.h,
    wl_message,
    name, CString,
    signature, CString,
    types, Ptr (Ptr WL_interface),
}}

{{ struct
    wayland-util.h,
    wl_interface,
    name, Ptr CChar,
    version, CInt,
    method_count, CInt,
    methods, Ptr WL_message,
    event_count, CInt,
    events, Ptr WL_message
}}

{{ struct
    wayland-util.h,
    wl_array,
    size, CSize,
    alloc, CSize,
    data, Ptr ()
}}
