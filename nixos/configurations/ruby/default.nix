{config, ...}: {
  # Imports
  imports = [
    ./hardware-configuration.nix
    ../../modules
  ];

  systemModules = {
    pipewire.enable = true;
    systemd-boot.enable = true;
    colemak.enable = true;
    fonts.enable = true;
    libinput.enable = true;
    gnome-keyring.enable = true;
    networkmanager.enable = true;
    kernel.ruby.enable = true;
    tlp.enable = true;
    fstrim.enable = true;
    polkit.enable = true;
    auto-cpufreq.enable = true;
    opendrop.enable = true;
    opengl.enable = true;
    sway.ruby.enable = true;
  };

  # Hostname
  networking.hostName = "ruby";

  # Users
  users.users.alex = {
    isNormalUser = true;
    extraGroups = ["networkmanager" "wheel" "video"];
  };

  # System State Version
  system.stateVersion = "23.05";

  # Issue/MOTD
  environment.etc = {
    issue = {
      text = "\e[31mWelcome to Ruby!\e[0m";
    };
  };


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
  
  # No Login Manager
  environment.loginShellInit = '' 
    [[ "$(tty)" == /dev/tty1 ]] && sway
  '';
}
