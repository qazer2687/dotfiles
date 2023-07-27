{
  config,
  pkgs,
  inputs,
  lib,
  ...
}: {
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

    home.stateVersion = "23.05";

}
