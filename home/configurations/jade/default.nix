{
  config,
  pkgs,
  inputs,
  lib,
  ...
}: {

  imports = [
    ../../modules
  ];

    home.packages = with pkgs; [

      # General
      firefox
      obs-studio
      vlc
      webcord-vencord

      # Programming
      vscodium

      # Gaming
      osu-lazer-bin
      prismlauncher
      lunar-client
      lutris
      protonup-qt

      # Environment
      polybarFull
      dmenu
      dunst
      scrot
      feh
      pavucontrol
      alacritty
      gnome.nautilus
      neofetch
      redshift
      easyeffects
    ];

    home.stateVersion = "23.05";

}
