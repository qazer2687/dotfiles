{pkgs ? import <nixpkgs> {}}:
pkgs.mkShell {
  packages = with pkgs; [
    statix
    alejandra
    deadnix
    sops
    llvmPackages_12.clang-tools
  ];
}
