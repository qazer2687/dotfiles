{pkgs ? import <nixpkgs> {}}:
pkgs.mkShell {
  packages = with pkgs; [
    statix
    alejandra
    deadnix
    sops
    nixd
    nil
    nixfmt
  ];
}
