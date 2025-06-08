let
  pkgs = import ./pinned.nix {
    overlays = [(import ./overlays.nix)];
  };
in
  with pkgs;
  mkShell {
    buildInputs = [
      bundix
      bundler
      nodejs
      postgresql
      python3
      ruby
      yarn
      pkg-config
      libyaml
      typescript
      typescript-language-server
    ];
  }
