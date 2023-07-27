{
  config,
  pkgs,
  inputs,
  lib,
  ...
}: {
  # Home Manager
  home-manager.users.alex = {
    # Packages
    home.packages = with pkgs; [
      # General
      firefox
      webcord-vencord

      # Programming
      vscodium

      # Productivity
      obsidian

      # Environment
      dunst
      polybarFull
      dmenu
      scrot
      feh
      pavucontrol
      alacritty
      gnome.nautilus
      redshift
      brightnessctl
      pamixer
      neofetch
    ];
  };
}
