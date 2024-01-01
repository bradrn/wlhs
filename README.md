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
