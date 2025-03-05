{
  lib,
  pkgs,
  ...
}: {
  imports = [
    ../../modules/home
  ];

  home.packages = with pkgs; [
    
    # Graphical
    obsidian
    nautilus
    fragments
    calibre
    vlc
    loupe
    ffmpeg-full
    libheif

    # Terminal
    ncdu
  
    # Custom Packages
    arnis
    zen-browser

    # Development
    sqlitebrowser # SQLite Database Browser
  ];

  # Enable rich presence support for Discord on the web.
  # services.arrpc.enable = true;

  modules = {

    # Desktop Environment
    hyprland.enable = true;
    hyprlock.enable = true;
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
    mpd.enable = true;
    direnv.enable = true;
    git.enable = true;
    bat.enable = true;
    neovim.enable = true;

    # GUI
    vscode.enable = true;

    # Security
    # gpg.enable = true;

    # Gaming
    # prismlauncher.enable = true;
    # mangohud.enable = true;
  };

  home.stateVersion = "24.11";
  home.homeDirectory = lib.mkForce "/home/alex";

  sops.defaultSopsFile = ../../../secrets/default.yaml;
  sops.age.sshKeyPaths = ["/home/alex/.ssh/id_ed25519"];
}
