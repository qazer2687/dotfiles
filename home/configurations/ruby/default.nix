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

  home-manager.sharedModules = [
    {
      homeModules = {
        programs = {
          bash.enable = true;
          direnv.enable = true;
          git.enable = true;
          mpd.enable = true;
          neovim.enable = true;
          alacritty.laptopConfig.enable = true;
          polybar.laptopConfig.enable = true;
          dunst.laptopConfig.enable = true;
          i3.laptopConfig.enable = true;
        };
      };
    }
  ];

  home.packages = with pkgs; [
    # General
    firefox
    webcord-vencord

    # Programming
    vscodium

    # Productivity
    obsidian

    # Environment
    dmenu
    scrot
    feh
    pavucontrol
    gnome.nautilus
    redshift
    brightnessctl
    pamixer
    neofetch
  ];

  home.stateVersion = "23.05";
}
