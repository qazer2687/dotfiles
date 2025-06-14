{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };
  outputs = { self, nixpkgs }:
    let
      supportedSystems = [ "x86_64-linux" "aarch64-linux" ];
      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
    in
    {
      packages = forAllSystems (system:
        let
          pkgs = import nixpkgs { inherit system; };
        in
        {
          jet = pkgs.callPackage ./dwl.nix { 
            configH = ./config/jet/config.h;
            enableXWayland = false;
            patches = [
              ./patches/dwl/vanitygaps-0.7.patch
            #  ./patches/dwl/bar-0.7.patch
              ./patches/dwl/ipc.patch
            #  ./patches/dwl/hot-reload-0.7.patch
              ./patches/dwl/autostart-0.7.patch
              ./patches/dwl/movestack.patch
            #  ./patches/dwl/push.patch
            ];
          };
          jade = pkgs.callPackage ./dwl.nix { 
            configH = ./config/jade/config.h;
            patches = [
            #  ./patches/dwl/vanitygaps-0.7.patch
              ./patches/dwl/bar-0.7.patch
            #  ./patches/dwl/ipc.patch
            #  ./patches/dwl/hot-reload-0.7.patch
              ./patches/dwl/autostart-0.7.patch
              ./patches/dwl/movestack.patch
            #  ./patches/dwl/push.patch
            ];
          };
        }
      );
    };
}