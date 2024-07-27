{
  lib,
  self,
  config,
  ...
}: let
  inherit (lib) mkDefault;
in {
  nixpkgs.config.allowUnfree = mkDefault true;

  nix.settings = {
    experimental-features = mkDefault [
      "nix-command"
      "flakes"
    ];
    keep-derivations = mkDefault true;
    keep-outputs = mkDefault true;
    auto-optimise-store = mkDefault true;
    sandbox = mkDefault true;
    require-sigs = false; # for remote builds
  };

  ## i forgot what this does (obsidian req maybe)
  nixpkgs.config.permittedInsecurePackages = [
    "electron-25.9.0"
  ];

  # User
  users.users.alex = {
    isNormalUser = true;
    extraGroups = ["networkmanager" "wheel" "video" "audio"];
    shell = pkgs.fish;
  };

  # Shell
  programs.fish.enable = true;

  ## required by most things incl sway and nvidia
  hardware.graphics.enable = true;

  # Dconf (gtk settings)
  programs.dconf.enable = true;

  # Locale
  time.timeZone = mkDefault "Europe/London";
  i18n.defaultLocale = mkDefault "en_GB.UTF-8";

  # Sops-Nix
  sops.defaultSopsFile = ./secrets/default.yaml;

  # Systemd
  systemd.coredump.enable = false;

  # Environment
  environment = {
    defaultPackages = lib.mkForce [];
    sessionVariables = {
      NIXPKGS_ALLOW_UNFREE = "1";
      NIXPKGS_ALLOW_INSECURE = "1";
      GTK_THEME = "Adwaita-dark";
    };
  };
}
