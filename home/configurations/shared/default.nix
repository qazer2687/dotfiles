{
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkDefault;
in {
  
  imports = [
    ./modules.nix
  ];

  home.packages = with pkgs; [
    statix
    alejandra
    deadnix
    nil
    comma
    ncdu
    bash
  ];

  home.stateVersion = mkDefault "23.05";
  home.homeDirectory = mkDefault "/home/alex";

  sops.defaultSopsFile = ../../../secrets/default.yaml;
  sops.age.sshKeyPaths = ["/home/alex/.ssh/id_ed25519"];
  #sops.secrets.defaultUserPassword.neededForUsers = true;
}