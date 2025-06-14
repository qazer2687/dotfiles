# Custom packages, that can be defined similarly to ones from nixpkgs
# You can build them using 'nix build .#example'
pkgs: {
  # example = pkgs.callPackage ./example { };
  widevinecdm-aarch64 = pkgs.callPackage ./widevinecdm-aarch64 {};
  arnis = pkgs.callPackage ./arnis {};
  zen-browser = pkgs.callPackage ./zen-browser {};
  pragmatapro = pkgs.callPackage ./pragmatapro {};
  dwl = pkgs.callPackage ./dwl {};
}
