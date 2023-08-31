{config, ...}: {
  # Imports
  imports = [
    ./hardware-configuration.nix
    ./modules.nix
  ];

  # Hostname
  networking.hostName = "ruby";

  # Disable XWayland & Xorg
  programs.xwayland.enable = false;
  services.xserver.enable = false;


  # Electron Wayland Support
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };

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
      text = ''\e[31mWelcome to Ruby!\e[0m'';
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
