{ inputs, lib, config, pkgs, ... }:
{
  imports = [
  
  # Boot
  ./boot/silentboot.nix
  ./boot/stage2patch.nix

  # Desktop
  ./desktop/gdm.nix
  ./desktop/i3.nix

  # Network
  ./network/networkmanager.nix

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