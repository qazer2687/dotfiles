{
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkDefault;
  
  # Custom Bash Aliases
  aliases = {
    "check" = "alejandra -q **/* && deadnix -e && statix fix";
    "rebuild" = "sudo nixos-rebuild switch --flake github:***REMOVED***/dotfiles#$(hostname) --refresh --option eval-cache false";
    "rebuild-local" = "sudo nixos-rebuild switch --flake .#$(hostname)";
  };
in {

  system.stateVersion = mkDefault "23.05";

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
  };

  ## i forgot what requires this, maybe vinegar or obsidian
  nixpkgs.config.permittedInsecurePackages = [
    "electron-25.9.0"
  ];

  # Default Fonts
  fonts.packages = with pkgs; [
    (nerdfonts.override {
      fonts = [
        "FiraCode"
        "FiraMono"
        "Iosevka"
      ];
    })
    atkinson-hyperlegible
  ];

  # Bash Aliases
  programs.bash = {
    shellAliases = aliases;
  };

  # Keyboard Layout
  console.keyMap = "colemak";
  services.xserver = {
    layout = "gb";
    xkbVariant = "colemak";
  };

  ## required by most things incl sway and nvidia
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  # Locale
  time.timeZone = mkDefault "Europe/London";
  i18n.defaultLocale = mkDefault "en_GB.UTF-8";

  # Environment
  programs.direnv.enable = true;
  programs.git.enable = true;
  environment = {
    defaultPackages = lib.mkForce [];
    sessionVariables = {
      NIXPKGS_ALLOW_UNFREE = "1";
      NIXPKGS_ALLOW_INSECURE = "1";
    };
  };
}
