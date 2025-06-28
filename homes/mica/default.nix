{
  lib,
  pkgs,
  ...
}: {
  imports = [
    ../../modules/home
  ];

  home.packages = with pkgs; [
    ncdu
    btop
  ];

  modules = {
    core.enable = true;
    fish.enable = true;
    fastfetch.enable = true;
  };

  home.stateVersion = "24.11";
  home.homeDirectory = lib.mkForce "/home/alex";

  sops = {
    defaultSopsFormat = "yaml";
    defaultSopsFile = ../../../secrets/default.yaml;
    age.keyFile = "/home/alex/.config/sops/age/keys.txt";
  };
}
