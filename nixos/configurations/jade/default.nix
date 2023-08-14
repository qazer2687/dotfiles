{
  config,
  pkgs,
  lib,
  ...
}: {
  # Imports
  imports = [
    ./hardware-configuration.nix
    ../../modules
  ];

  systemModules = {
    pipewire.enable = true;
    easyeffects.enable = true;
    systemd-boot.enable = true;
    gdm.enable = true;
    i3.enable = true;
    steam.enable = true;
    colemak.enable = true;
    fonts.enable = true;
    libinput.enable = true;
    zram.enable = true;
    keepassxc.enable = true;
    gnome-keyring.enable = true;
    networkmanager.enable = true;
    udev.via.enable = true;
    kernel.jade.enable = true;
    fstrim.enable = true;
    nvidia.enable = true;
  };

  # Hostname
  networking.hostName = "jade";

  # Users
  users.users.alex = {
    isNormalUser = true;
    extraGroups = ["networkmanager" "wheel"];
  };

  # System State Version
  system.stateVersion = "23.05";

  # Allow Unfree Software
  nixpkgs.config.allowUnfree = true;

  # Nix Experimental Features
  nix.settings.experimental-features = ["nix-command" "flakes"];

  # Locale
  time.timeZone = "Europe/London";
  i18n.defaultLocale = "en_GB.UTF-8";

  # Nix Miscellaneous Options
  nix.extraOptions = ''
    keep-outputs = true
    keep-derivations = true
  '';

  environment.etc = {
    "jdks/17".source = lib.getBin pkgs.openjdk17;
    "jdks/8".source = lib.getBin pkgs.openjdk8;
  };
}
