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
    gammastep
    fragments # Torrent Client
    calibre
    vlc
    teams-for-linux
    loupe # Image Viewer
  ];

  # Enable rich presence support for Discord on the web.
  services.arrpc.enable = true;

  modules = {
    # Environment
    #sway.enable = true;
    #hyprland.enable = true;
    niri.enable = true;
    waybar.enable = true;
    foot.enable = true;
    mako.enable = true;
    wofi.enable = true;
    theme.enable = true;
    
    # Programs
    firefox.enable = true;
    fish.enable = true;
    webcam.enable = true;
    bat.enable = true;
    eza.enable = true;
    vscode.enable = true;
    git.enable = true;
    direnv.enable = true;
    #neovim.enable = true;

    # Security
    #gpg.enable = true;

    # Gaming
    prismlauncher.enable = true;
    mangohud.enable = true;
  };

  home.stateVersion = "24.11";
  home.homeDirectory = lib.mkForce "/home/alex";

  sops.defaultSopsFile = ../../../secrets/default.yaml;
  sops.age.sshKeyPaths = ["/home/alex/.ssh/id_ed25519"];
}
