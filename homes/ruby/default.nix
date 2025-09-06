{
  pkgs,
  lib,
  ...
}: {
  imports = [
    ../../modules/home
  ];

  home.packages = with pkgs; [
    obsidian
    nautilus
    gammastep
    vlc
  ];

  modules = {
    sway.enable = true;
    waybar.enable = true;
    foot.enable = true;
    mako.enable = true;
    wofi.enable = true;
    theme.enable = true;

    firefox.enable = true;
    fish.enable = true;
    webcam.enable = true;
    eza.enable = true;
    vscode.enable = true;
    git.enable = true;
    direnv.enable = true;
  };

  home.stateVersion = "23.05";
  home.homeDirectory = lib.mkForce "/home/alex";

  sops = {
    defaultSopsFormat = "yaml";
    defaultSopsFile = ../../../secrets/default.yaml;
    age.keyFile = "/home/alex/.config/sops/age/keys.txt";
  };
}
