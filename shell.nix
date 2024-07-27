{pkgs ? import <nixpkgs> {}}:
pkgs.mkShell {
  packages = with self.packages; [
    statix
    alejandra
    deadnix
    sops
  ];
}
