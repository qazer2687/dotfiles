{
  config,
  pkgs,
  inputs,
  lib,
  ...
}: {
  # Imports
  imports = [
    ./hardware-configuration.nix
    ../../modules

    # Software Configuration
    ./configs/polybar
    ./configs/i3
    ./configs/alacritty
    ./configs/dunst
  ];

  # Modules
  systemModules = {
    boot = {
      loader.systemd-boot.enable = true;
    };
    desktop = {
      gdm.enable = true;
      gdm.autologin.enable = false;
      i3.enable = true;
    };
    network = {
      networkmanager.enable = true;
      networkmanager.firewall.enable = false;
    };
    system = {
      kernel.laptop.enable = true;
    };
    audio = {
      pipewire.enable = true;
    };
    video = {
      nvidia.enable = false;
    };
    gaming = {
      steam.enable = false;
    };
    misc = {
      colemak.enable = true;
      fonts.enable = true;
      keyring.enable = true;
      mouseaccel.enable = true;
      zram.enable = true;
      tlp.enable = true;
    };
  };

  # Hostname
  networking.hostName = "ruby";

  # Users
  users.users.alex = {
    isNormalUser = true;
    extraGroups = ["networkmanager" "wheel"];
  };
}
