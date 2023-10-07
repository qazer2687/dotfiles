{pkgs, ...}: {
  imports = [
    ./modules.nix
  ];

  home.packages = with pkgs; [
    # General
    #obs-studio
    #vlc

    # Gaming
    #osu-lazer-bin
    #prismlauncher
    #lunar-client
    #lutris
    #protonup-qt
  ];

  sops.secrets.spotify_password.path = "/home/alext/.config/spotifyd/password";
}
