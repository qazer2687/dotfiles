{ inputs, lib, config, pkgs, ... }:
{
  imports = [
  
  # Boot
  ./boot/silentboot.nix
  ./boot/stage2patch.nix
  ./boot/systemd-boot.nix

  # Desktop
  ./desktop/gdm.nix
  ./desktop/i3.nix
  ./desktop/autologin.nix

  # Network
  ./network/networkmanager.nix
  ./network/firewall.nix

  # Audio
  ./audio/pipewire.nix

  # Video
  ./video/nvidia.nix

  # Gaming
  ./gaming/steam.nix
  ./gaming/minecraftserver.nix

  # Misc
  ./misc/mouseaccel.nix
  ./misc/tlp.nix
  ./misc/zram.nix
  ./misc/colemak.nix
  ./misc/keyring.nix
  ./misc/fonts.nix

  ];
}