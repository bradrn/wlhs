# wlhs

This project aims to develop a set of Haskell bindings for `wlroots`
  (and some parts of `libwayland`)
At the moment it focusses on low-level bindings, in the `wlhs-bindings` package.

**Warning: this project has just begun!**
Currently, the bindings are highly incomplete.
Please feel free to help us expand them!

# Development

**We currently target wlroots version `0.17.1`.**

There is a Nix development flake available, which may be accessed via `nix develop`.
For [direnv][ghub:direnv] users, an `.envrc` file is also provided.

[ghub:direnv]: https://github.com/direnv/direnv

## hsc2hs extensions

`wlhs-bindings` contains a custom `Setup.hs`,
  which extends [hsc2hs](https://github.com/haskell/hsc2hs) files with some custom syntax.
This is probably best illustrated by example:

<table>
<tr>
<th>Macro call</th>
<th>Equivalent to</th>
</tr>
<tr>
<td>

```
{{ struct
    include.h,
    wl_type_name
}}
```

</td>
<td>

```hs
data {-# CTYPE "include.h" "struct wl_type_name" #-} WL_type_name
    deriving (Show)
```

(Note: requires `{-# LANGUAGE EmptyDataDeriving #-}`)

</td>
</tr>
<td>

```
{{ struct
    include.h,
    wl_type_name,
    field1, Type1,
    field2, Type2,
    nested field, Type2
}}
```

</td>
<td>

```hs
data {-# CTYPE "include.h" "struct wl_type_name" #-} WL_type_name
    = WL_type_name
    { wl_type_name_field1 :: Type1
    , wl_type_name_field2 :: Type2
    , wl_type_name_nested_field :: Type2
    } deriving (Show)
    
instance Storable WL_type_name where
    alignment _ = #alignment struct wl_type_name
    sizeOf _ = #size struct wl_type_name
    peek ptr = WL_type_name
        <$> (#peek struct wl_type_name, field1) ptr
        <*> (#peek struct wl_type_name, field2) ptr
        <*> (#peek struct wl_type_name, nested.field) ptr
    poke ptr t = do
        (#peek struct wl_type_name, field1) ptr (wl_type_name_field1 t)
        (#peek struct wl_type_name, field2) ptr (wl_type_name_field2 t)
        (#peek struct wl_type_name, nested.field) ptr (wl_type_name_nested_field t)
```

</td>
</tr>
<tr>
<td>

```
{{ enum
    WL_type_name,
    WLR_ENUM_VALUE_1,
    WLR_ENUM_VALUE_2
}}
```

</td>
<td>

```hs
type WL_type_name = CInt

pattern WLR_ENUM_VALUE_1 :: (Eq a, Num a) => a
pattern WLR_ENUM_VALUE_1 = #const WLR_ENUM_VALUE_1 

pattern WLR_ENUM_VALUE_2 :: (Eq a, Num a) => a
pattern WLR_ENUM_VALUE_2 = #const WLR_ENUM_VALUE_2 
```

</td>
</tr>
</table>
