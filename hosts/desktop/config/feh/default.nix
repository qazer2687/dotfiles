{ config, pkgs, ... }:
{
  # Tmpfiles rule to move wallpaper.
  systemd.tmpfiles.rules = [
    "L+ /home/alex/.config/feh/wallpaper.png 0755 alex alex - ${./wallpaper.png}"
  ];
}
