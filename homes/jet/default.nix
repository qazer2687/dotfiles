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
    # Graphical
    obsidian
    nautilus
    # fragments
    # Broken on unstable.
    # calibre
    vlc
    loupe
    jellyfin-media-player

    # Terminal
    ncdu
    btop
    #neovim

    # Internal
    #arnis

    # External
    inputs.zen.packages."${system}".default

    # Misc
    ffmpeg-full
    libheif
  ];

  # Enable rich presence support for Discord on the web.
  # services.arrpc.enable = true;

  modules = {
    # Desktop Environment
    niri.enable = true;
    #hyprland.enable = true;
    #hyprlock.enable = true;
    waybar.enable = true;
    mako.enable = true;
    wofi.enable = true;
    theme.enable = true;

    # CLI
    fish.enable = true;
    foot.enable = true;
    fastfetch.enable = true;
    webcam.enable = true;
    eza.enable = true;
    # mpd.enable = true;
    direnv.enable = true;
    git.enable = true;
    bat.enable = true;
    # neovim.enable = true;

    # GUI
    #vscode.enable = true;
    zed.enable = true;
  };

  home.stateVersion = "24.11";
  home.homeDirectory = lib.mkForce "/home/alex";

  sops = {
    defaultSopsFormat = "yaml";
    defaultSopsFile = ../../../secrets/default.yaml;
    age.keyFile = "/home/alex/.config/sops/age/keys.txt";
    };
  }
