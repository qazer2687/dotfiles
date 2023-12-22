{lib, ...}: let
  inherit (lib) mkDefault;
in {
  # System State Version
  system.stateVersion = mkDefault "23.05";

  # Allow Unfree Software
  nixpkgs.config.allowUnfree = mkDefault true;

  # Allow Insecure Packages
  nixpkgs.config.permittedInsecurePackages = [
      "electron-25.9.0"
    ];

  # Nix Settings & Experimental Features
  nix.settings = {
    experimental-features = mkDefault [
      "nix-command"
      "flakes"
      "auto-allocate-uids"
    ];
    auto-optimise-store = mkDefault true;
    auto-allocate-uids = mkDefault false;
    keep-derivations = mkDefault true;
    keep-outputs = mkDefault true;
    sandbox = mkDefault false;
  };

  # Logrotate Bug Workaround
  services.logrotate.enable = false;
  services.logrotate.checkConfig = false;

  # Locale
  time.timeZone = mkDefault "Europe/London";
  i18n.defaultLocale = mkDefault "en_GB.UTF-8";

  # Environment
  environment = {
    defaultPackages = lib.mkForce [];
    variables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
    };
    sessionVariables = {
      NIXPKGS_ALLOW_UNFREE = "1"; # Allow Unfree Packages
      NIXPKGS_ALLOW_INSECURE = "1"; # Allow Insecure Packages
    };
  };
}
