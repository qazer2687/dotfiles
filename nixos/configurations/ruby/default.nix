{config, ...}: {
  # Imports
  imports = [
    ./hardware-configuration.nix
    ../../modules
  ];

  systemModules = {
    pipewire.enable = true;
    systemd-boot.enable = true;
    gdm.enable = true;
    i3.enable = true;
    colemak.enable = true;
    fonts.enable = true;
    libinput.enable = true;
    zram.enable = true;
    gnome-keyring.enable = true;
    networkmanager.enable = true;
    kernel.ruby.enable = true;
    fstrim.enable = true;
    polkit.enable = true;
    auto-cpufreq.enable = true;
    opendrop.enable = true;
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
