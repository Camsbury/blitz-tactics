let
  pkgs = import <nixpkgs> {
    overlays = [(import ./overlays.nix)];
  };
  nodePkgs = import ./pinned.nix {
    overlays = [(import ./overlays.nix)];
  };
in
  with pkgs;
  mkShell {
    buildInputs = [
      bundix
      bundler
      nodePkgs.nodejs
      postgresql
      python
      ruby
      nodePkgs.yarn
    ];
  }
