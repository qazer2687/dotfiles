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

    # Misc Libs
    ffmpeg-full
    libheif
  ];

  # Enable rich presence support for Discord on the web.
  # services.arrpc.enable = true;

  modules = {
    # Desktop Environment
    hyprland.enable = true;
    hyprlock.enable = true;
    
    waybar.enable = true;
    mako.enable = true;
    tofi.enable = true;
    theme.enable = true;

    # CLI
    fish.enable = true;
    foot.enable = true;
    fastfetch.enable = true;
    webcam.enable = true;
    eza.enable = true;
    direnv.enable = true;
    git.enable = true;
    zoxide.enable = true;
    screenshot.enable = true;

    # GUI
    zed.enable = true;
    firefox.enable = true;
  };

  home.stateVersion = "24.11";
  home.homeDirectory = lib.mkForce "/home/alex";

  sops = {
    defaultSopsFormat = "yaml";
    defaultSopsFile = ../../../secrets/default.yaml;
    age.keyFile = "/home/alex/.config/sops/age/keys.txt";
  };
}
