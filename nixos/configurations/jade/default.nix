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

  systemModules = {
    boot = {
      loader.systemd-boot.enable = true;
    };
    desktop = {
      gdm.enable = true;
      gdm.autologin.enable = false;
      i3.enable = true;
    };
    system = {
      udev.via.enable = true;
      kernel.desktop.enable = true;
    };
    network = {
      networkmanager.enable = true;
      networkmanager.firewall.enable = false;
    };
    audio = {
      pipewire.enable = true;
    };
    video = {
      nvidia.enable = true;
    };
    gaming = {
      steam.enable = true;
    };
    misc = {
      colemak.enable = true;
      fonts.enable = true;
      keyring.enable = true;
      mouseaccel.enable = true;
      zram.enable = true;
      tlp.enable = false;
    };
  };

  # Hostname
  networking.hostName = "jade";

  # Users
  users.users.alex = {
    isNormalUser = true;
    extraGroups = ["networkmanager" "wheel"];
  };

  environment.etc = {
    "jdks/17".source = lib.getBin pkgs.openjdk17;
    "jdks/8".source = lib.getBin pkgs.openjdk8;
  };
}
