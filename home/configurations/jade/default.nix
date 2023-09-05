{pkgs, ...}: {
  imports = [
    ./modules.nix
  ];

  home.packages = with pkgs; [
    # General
    obs-studio
    vlc

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
  ];

  sops.secrets.spotify_password.path = "/home/alex/.config/spotifyd/password";
}
