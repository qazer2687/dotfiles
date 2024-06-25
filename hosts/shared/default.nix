{
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (lib) mkDefault; 

  aliases = {
    "check" = "alejandra -q **/* && deadnix -e && statix fix";
    <if x86_64>
    "rebuild" = "sudo nixos-rebuild switch --flake github:qazer2687/dotfiles#$(hostname) --refresh --option eval-cache false";
    <if aarch64>
    "rebuild" = "darwin-rebuild switch --flake github:qazer2687/dotfiles#$(hostname) --refresh --option eval-cache false";
  };
in {
  programs.bash = {
    shellAliases = aliases;
  };

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

  # User
  users.users.alex = {
    isNormalUser = true;
    extraGroups = ["networkmanager" "wheel" "video"];
    shell = pkgs.fish;
  };

  # Shell
  programs.fish.enable = true;

  # Default Fonts
  fonts.packages = with pkgs; [
    (nerdfonts.override {
      fonts = [
        "FiraCode"
        "FiraMono"
        "Iosevka"
        "LiberationMono"
      ];
    })
    atkinson-hyperlegible
    noto-fonts-color-emoji
    noto-fonts-cjk-sans
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

  # Zram
  zramSwap = {
    enable = false;
    algorithm = "zstd";
    memoryPercent = 25;
  };

  # Systemd
  systemd.coredump.enable = false;

  # Environment
  programs.direnv.enable = true; 
  environment = {
    defaultPackages = lib.mkForce [];
    sessionVariables = {
      NIXPKGS_ALLOW_UNFREE = "1";
      NIXPKGS_ALLOW_INSECURE = "1";
      GTK_THEME = "Adwaita-dark";
    };
  };
}
