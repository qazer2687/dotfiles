{pkgs ? import <nixpkgs> {}}:
pkgs.mkShell {
  # Packages
  packages = with pkgs; [
    statix
    alejandra
    deadnix
    sops
  ];

  # Environment Variables
  # ...
}
