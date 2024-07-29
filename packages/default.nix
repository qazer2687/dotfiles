pkgs: let
  packages = {
    widevinecdm-aarch64 = pkgs.callPackage ./widevinecdm-aarch64 {};
  };
in {
  customPackages = final: _prev: packages final.pkgs;
}
