{ inputs, lib, config, pkgs, ... }:
{
  imports = [

  # Audio
  ./audio/pipewire.nix

  # Boot
  ./boot/silent.nix
  ./boot/stage2patch.nix
  ./boot/loader.nix

  # Desktop
  ./desktop/gdm.nix
  ./desktop/i3.nix

  # Gaming
  ./gaming/steam.nix

  # Misc
  ./misc/colemak.nix
  ./misc/fonts.nix
  ./misc/keyring.nix
  ./misc/mouseaccel.nix
  ./misc/tlp.nix
  ./misc/zram.nix
  
  # Network
  ./network/networkmanager.nix
 
  # System
  ./system/udev.nix
  ./system/kernelConfig.nix

  # Video
  ./video/nvidia.nix




  ];
}