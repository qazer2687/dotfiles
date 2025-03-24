{
  lib,
  pkgs,
  ...
}: {
  imports = [
    ../../modules/home
  ];

  home.packages = with pkgs; [
    obsidian
    nautilus
    obs-studio
    lunar-client
    vlc
    vesktop
  ];

  /*
  services.flatpak.packages = [
    # Can't install from flatpakref.
    # https://github.com/gmodena/nix-flatpak/issues/78
  ];
  */

  modules = {
    # X11
    i3.enable = true;
    alacritty.enable = true;
    polybar.enable = true;
    dunst.enable = true;

    # Wayland
    sway.enable = true;
    hyprland.enable = true;
    waybar.enable = true;
    foot.enable = true;
    mako.enable = true;
    wofi.enable = true;

    git.enable = true;
    theme.enable = true;
    firefox.enable = true;
    fish.enable = true;

    # Development
    vscode.enable = true;
    direnv.enable = true;
  };

  home.stateVersion = "23.05";
  home.homeDirectory = lib.mkForce "/home/alex";

  sops.defaultSopsFile = ../../../secrets/default.yaml;
  
}
