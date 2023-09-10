{
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkDefault;
in {
  # Global HM Packages
  home.packages = with pkgs; [
    alejandra
    deadnix
    statix
  ];

  # Default Settings
  home.stateVersion = mkDefault "23.05";
  home.homeDirectory = mkDefault "/home/alex";

  # SOPS
  sops.defaultSopsFile = ../../../secrets/default.yaml;
  sops.age.sshKeyPaths = ["/home/alex/.ssh/id_ed25519"];
  sops.secrets.defaultUserPassword.neededForUsers = true;
}
passwordFile = config.sops.secrets.defaultUserPassword.path;