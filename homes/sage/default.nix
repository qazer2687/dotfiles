{
  lib,
  pkgs,
  ...
}: {
  imports = [
    ../../modules/home
  ];

  # Packages
  home.packages = with pkgs; [
    # Programs
    obsidian
    mpv
    loupe
    proton-vpn
    nautilus
    lutris
    lmstudio
    obs-studio
    boxflat
    vial

    # Utilities
    gdu
    btop
    killall

    # Wine
    wineWow64Packages.stable
    #wineWowPackages.waylandFull
    winetricks

    go
  ];

  programs.opencode.enable = true;

  modules = {
    # Development
    direnv.enable = true;
    git.enable = true;

    # CLI
    eza.enable = true;
    zoxide.enable = true;
    utilities.enable = true;
    fish.enable = true;
    kitty.enable = true;
    fastfetch.enable = true;

    # Theming
    fonts.enable = true;
    theme.enable = true;

    # Desktop Environment
    hyprland.enable = true;
    #niri.enable = true;
    hyprlock.enable = true;
    hypridle.enable = true;
    waybar.enable = true;
    mako.enable = true;
    tofi.enable = true;
    clipboard.enable = true;

    # Applications
    firefox.enable = true;
    vesktop.enable = true;
    vscode.enable = true;
    zed.enable = true;

    # Gaming
    mangohud.enable = true;
    prismlauncher.enable = true;

    replays.enable = true;
  };

  home.stateVersion = "25.05";
  home.homeDirectory = lib.mkForce "/home/alex";

  sops = {
    defaultSopsFormat = "yaml";
    defaultSopsFile = ../../../secrets/default.yaml;
    age.keyFile = "/home/alex/.config/sops/age/keys.txt";
  };
}
