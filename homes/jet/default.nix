{
  lib,
  pkgs,
  ...
}: {
  imports = [
    ../../modules/home
  ];

  home.packages = with pkgs; [
    # Powerful knowledge base that works on top of a
    # local folder of plain text Markdown files
    obsidian

    # File manager for GNOME.
    nautilus

    # Cross-platform media player and streaming server.
    vlc

    # Simple image viewer application written with GTK4 and Rust
    loupe

    # Disk usage analyzer with console interface.
    gdu

    # Monitor of resources.
    btop

    # Open source clone of the Microprose game “Transport Tycoon Deluxe”.
    openttd-jgrpp

    protonvpn-gui

    telegram-desktop

    # Misc Libs
    ffmpeg-full
    libheif
  ];

  # Enable rich presence support for Discord on the web.
  # services.arrpc.enable = true;

  modules = {
    core.enable = true;

    # Desktop Environment
    hyprland.enable = true;
    hyprlock.enable = true;

    waybar.enable = true;
    mako.enable = true;
    tofi.enable = true;

    # CLI
    fish.enable = true;
    foot.enable = true;
    fastfetch.enable = true;

    # GUI
    firefox.enable = true;
    vscode.enable = true;
  };

  home.stateVersion = "24.11";
  home.homeDirectory = lib.mkForce "/home/alex";

  sops = {
    defaultSopsFormat = "yaml";
    defaultSopsFile = ../../../secrets/default.yaml;
    age.keyFile = "/home/alex/.config/sops/age/keys.txt";
  };
}
