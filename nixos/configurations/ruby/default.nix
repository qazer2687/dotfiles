{config, ...}: {
  # Imports
  imports = [
    ./hardware-configuration.nix
    ../../modules
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
      mouseaccel.enable = true;
      zram.enable = true;
      tlp.enable = true;
    };
    security = {
      keepassxc.enable = false;
      gnome-keyring.enable = true;
    };
  };

  # Hostname
  networking.hostName = "ruby";

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
}
