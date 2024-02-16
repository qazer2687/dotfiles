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
    noto-fonts-color-emoji
  ];

  # Bash Aliases
  programs.bash = {
    shellAliases = aliases;
  };

  # Keyboard Layout
  console.keyMap = "colemak";
  services.xserver.xkb = {
    layout = "gb";
    variant = "colemak";
  };

  # PAM (allow users to request rtprio)
  security.pam.loginLimits = [
    {
      domain = "@users";
      item = "rtprio";
      type = "-";
      value = 1;
    }
  ];

  ## required by most things incl sway and nvidia
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  # Dconf (gtk settings)
  programs.dconf.enable = true;

  # Locale
  time.timeZone = mkDefault "Europe/London";
  i18n.defaultLocale = mkDefault "en_GB.UTF-8";

  # Sops-Nix
  defaultSopsFile = ./secrets/default.yaml;

  # Environment
  programs.direnv.enable = true;
  environment = {
    defaultPackages = lib.mkForce [];
    sessionVariables = {
      NIXPKGS_ALLOW_UNFREE = "1";
      NIXPKGS_ALLOW_INSECURE = "1";
    };
  };
}
