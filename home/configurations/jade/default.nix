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

  home-manager.sharedModules = {
    homeModules = {
      programs = {
        bash.enable = true;
        direnv.enable = true;
        git.enable = true;
        mpd.enable = true;
        neovim.enable = true;
        udiskie.enable = false;
      };
    };
  };

  home-manager.users.alex = {
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
  };
}
