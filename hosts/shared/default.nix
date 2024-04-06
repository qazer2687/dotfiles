{
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (lib) mkDefault;

  # Custom Bash Aliases
  aliases = {
    "check" = "alejandra -q **/* && deadnix -e && statix fix";
    "nr" = "sudo nixos-rebuild switch --flake github:qazer2687/dotfiles#$(hostname) --refresh --option eval-cache false";
    "nr -l" = "sudo nixos-rebuild switch --flake .#$(hostname)";
  };
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
  };

  ## i forgot what this does (obsidian req maybe)
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

  # Power Profiles Daemon
  services.power-profiles-daemon = {
    enable = true;
  };

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
  sops.defaultSopsFile = ./secrets/default.yaml;

  # zram
  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 50;
  };

  # Environment
  programs.direnv.enable = true;
  environment = {
    defaultPackages = lib.mkForce [];
    sessionVariables = {
      GTK_THEME = "Adwaita-dark";
      NIXPKGS_ALLOW_UNFREE = "1";
      NIXPKGS_ALLOW_INSECURE = "1";
    };
  };
}
