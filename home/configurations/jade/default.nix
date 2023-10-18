{pkgs, ...}: {
  imports = [
    ./modules.nix
  ];

  sops.secrets.spotify_password.path = "/home/alext/.config/spotifyd/password";
}
