# Custom packages, that can be defined similarly to ones from nixpkgs
# You can build them using 'nix build .#example'
pkgs: {
  # example = pkgs.callPackage ./example { };
  #widevinecdm-aarch64 = pkgs.callPackage ./widevinecdm-aarch64 {};
  arnis = pkgs.callPackage ./arnis {};
  pragmatapro = pkgs.callPackage ./pragmatapro {};
  TX02 = pkgs.callPackage ./TX02 {};

  fast-font = pkgs.callPackage ./fast-font {};
  fraktion-sans = pkgs.callPackage ./fraktion-sans {};
  lettra-mono = pkgs.callPackage ./lettra-mono {};
  space-grotesk = pkgs.callPackage ./space-grotesk {};

  immich-cli = pkgs.callPackage ./immich-cli {};
}
