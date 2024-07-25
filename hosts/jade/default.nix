{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ../../hardware/jade
    ../../modules/nixos
  ];

  nixpkgs = {
    overlays = [
      outputs.overlays.additions
      outputs.overlays.modifications
    ];
    config = {
      allowUnfree = true;
    };
  };

  nix = let
    flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
  in {
    settings = {
      experimental-features = "nix-command flakes";
      flake-registry = "";
      nix-path = config.nix.nixPath;
      keep-derivations = true;
      keep-outputs = true;
      auto-optimise-store = true;
      sandbox = true;
      require-sigs = false;
    };
    channel.enable = false;
    registry = lib.mapAttrs (_: flake: {inherit flake;}) flakeInputs;
    nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;
  };

  # Hostname
  networking.hostName = "jade";

  # User
  users.users = {
    alex = {
      initialPassword = "xela";
      isNormalUser = true;
      openssh.authorizedKeys.keys = [
        # TODO: Add your SSH public key(s) here...
      ];
      extraGroups = ["networkmanager" "wheel" "video" "audio"];
      shell = pkgs.fish;
    };
  };

  # Shell
  programs.fish.enable = true;

  # Hardware
  hardware = {
    graphics = {
      enable = true;
    };
    boot = {
      loader.efi.efiSysMountPoint = "/boot/efi"; #! Required for everything to not shit itself when I rebuild...
      kernelParams = [
        # TODO: Move kernelParams from module to here...
      ];
    };
  };

  # Autologin
  services.getty.autologinUser = "alex";
  environment.loginShellInit = ''
    [[ "$(tty)" == /dev/tty1 ]] && startx
  '';

  # Swap
  swapDevices = [{
    device = "/swapfile";
    size = 16 * 1024;
  }];

  # Environment
  environment = {
    sessionVariables = {
      # Theme
      GTK_THEME = "Adwaita-dark";

      # Nixpkgs
      NIXPKGS_ALLOW_UNFREE = "1";
      NIXPKGS_ALLOW_INSECURE = "1";
    };
    defaultPackages = lib.mkForce [];
  };

  # X Server
  services.xserver = {
    enable = true;
    displayManager.startx.enable = true;
  };

  # Custom Kernel
  boot.kernelPackages = lib.mkForce pkgs.linuxPackages_xanmod ;
  
  # Modules
  modules = {
    # Network
    networkmanager.enable = true;

    kernel.enable = true;
    nvidia.enable = true;
    pipewire.enable = true;
    systemd-boot.enable = true;
    steam.enable = true;
    filesystem.enable = true;
    fonts.enable = true;
    keymap.enable = true;
    zram.enable = true;

    # Utilities
    nh.enable = true;
  };

  # SOPS
  sops.defaultSopsFile = ./secrets/default.yaml;

  # Locale
  time.timeZone = "Europe/London";
  i18n.defaultLocale = "en_GB.UTF-8";

  # Did you read the comment?
  system.stateVersion = "23.05";
}