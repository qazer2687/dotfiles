{pkgs, ...}: {
  imports = [
    ../../modules
    <sops-nix/modules/home-manager/sops.nix>
  ];

  homeModules = {
    programs = {
      bash.enable = true;
      direnv.enable = true;
      git.enable = true;
      neovim.enable = true;
      alacritty.desktopConfig.enable = true;
      polybar.desktopConfig.enable = true;
      dunst.desktopConfig.enable = true;
      i3.desktopConfig.enable = true;
    };
    services = {
      spotifyd.enable = true;
    };
  };

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
    dmenu
    scrot
    feh
    pavucontrol
    gnome.nautilus
    neofetch
    redshift
    easyeffects
  ];

  home.stateVersion = "23.05";
  home.homeDirectory = "/home/alex";
  config.sops.age.sshKeyPaths = ["$HOME/.ssh/id_ed25519"];
}
