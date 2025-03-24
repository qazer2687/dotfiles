{
  lib,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ../../modules/home
  ];

  home.packages = with pkgs; [
    ncdu
  ];

  modules = {
    fish.enable = true;
    fastfetch.enable = true;
    eza.enable = true;
    direnv.enable = true;
    git.enable = true;
  };

  home.stateVersion = "24.11";
  home.homeDirectory = lib.mkForce "/home/alex";

  sops.defaultSopsFile = ../../../secrets/default.yaml;
  sops.age.sshKeyPaths = ["/home/alex/.ssh/id_ed25519"];
}
