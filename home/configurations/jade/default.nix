{pkgs, ...}: {
  imports = [
    ./modules.nix
  ];

  home.packages = with pkgs; [
    # General
    #obs-studio
    #vlc
  ];

  sops.secrets.spotify_password.path = "/home/alext/.config/spotifyd/password";
}
