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
    obsidian
    nautilus
    obs-studio
    vlc
    vesktop
    loupe
    mumble

    ncdu
    btop
    killall

    lunar-client

    # Misc
    ffmpeg-full
    libheif

    vinegar
  ];

  # Services
  services = {
    arrpc.enable = true;
  };

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

    # Gaming
    mangohud.enable = true;
    prismlauncher.enable = true;

    firefox.enable = true;

    # Development
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
