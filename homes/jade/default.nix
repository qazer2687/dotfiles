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
    obsidian
    nautilus
    obs-studio
    vlc
    vesktop
    loupe

    ncdu
    btop

    inputs.zen.packages."${system}".default

    # Misc
    ffmpeg-full
    libheif
  ];

  modules = {
    # Desktop Environment
    dwl.enable = true;
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
    # mpd.enable = true;
    direnv.enable = true;
    git.enable = true;
    bat.enable = true;
    # neovim.enable = true;
    zoxide.enable = true;

    # Gaming
    mangohud.enable = true;

    # GUI
    #vscode.enable = true;
    zed.enable = true;
  };

  home.stateVersion = "25.05";
  home.homeDirectory = lib.mkForce "/home/alex";

  sops = {
    defaultSopsFormat = "yaml";
    defaultSopsFile = ../../../secrets/default.yaml;
    age.keyFile = "/home/alex/.config/sops/age/keys.txt";
  };
}
