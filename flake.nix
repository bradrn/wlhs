{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system}.extend (final: prev: {
          wlroots = prev.wlroots.overrideAttrs (old: rec {
            version = "0.17.1";
            src = pkgs.fetchFromGitLab {
              domain = "gitlab.freedesktop.org";
              owner  = "wlroots";
              repo   = "wlroots";
              rev    = version;
              hash   = "sha256-Z0gWM7AQqJOSr2maUtjdgk/MF6pyeyFMMTaivgt+RMI=";
            };
            patches = []; # Commit fe53ec693789afb44c899cad8c2df70c8f9f9023 is in 0.17.1.
          });
        });
        haskellPackages = pkgs.haskellPackages.extend (final: prev: {
          wlhs-bindings = prev.callCabal2nix "wlhs-bindings" ./. { };
        });
      in {
        devShells.default = haskellPackages.shellFor {
          packages = p: [ p.wlhs-bindings ];
          buildInputs = with haskellPackages; [
            cabal-install
            haskell-language-server
          ];
        };
      }
    );
}
