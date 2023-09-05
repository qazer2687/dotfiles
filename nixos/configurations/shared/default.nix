{
  pkgs,
  lib,
  ...
}: let
  inherit (lib) mkDefault;
in {
  # Users
  users.users.alex = {
    isNormalUser = true;
    extraGroups = ["networkmanager" "wheel" "video"];
  };

  # System State Version
  system.stateVersion = mkDefault "23.05";

  # Allow Unfree Software
  nixpkgs.config.allowUnfree = mkDefault true;

  # Nix Settings & Experimental Features
  nix.settings = {
    experimental-features = mkDefault [
      "nix-command"
      "flakes"
      "auto-allocate-uids"
    ];
    auto-optimise-store = mkDefault true;
    auto-allocate-uids = mkDefault true;
    keep-derivations = mkDefault true;
    keep-outputs = mkDefault true;
    sandbox = mkDefault false;
  };

  # Locale
  time.timeZone = mkDefault "Europe/London";
  i18n.defaultLocale = mkDefault "en_GB.UTF-8";

  # Multimc Java Pinning
  environment.etc = {
    "jdks/17".source = lib.getBin pkgs.openjdk17;
    "jdks/8".source = lib.getBin pkgs.openjdk8;
  };
}
