{lib, ...}: let
  inherit (lib) mkDefault;
in {
  # Global Tools
  home.packages = with pkgs; [
    alejandra
    deadnix
    statix
  ];

  home.stateVersion = "23.05";
  home.homeDirectory = mkDefault "/home/alex";
  sops.defaultSopsFile = ../../../secrets/default.yaml;
  sops.age.sshKeyPaths = ["/home/alex/.ssh/id_ed25519"];
}
