{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ../../hardware/jet
    ../../hardware/jet/apple-silicon-support
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
  networking.hostName = "jet";

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
    asahi = {
      withRust = true;
      useExperimentalGPUDriver = true;
      experimentalGPUInstallMode = "replace"; ## driver breaks sway, overlay fails to compile, replace doesn't work in pure eval
      setupAsahiSound = true;
      peripheralFirmwareDirectory = ../../firmware/jet;
    };
  };
  boot = {
    kernelParams = [
      "apple_dcp.show_notch=1" ## enable notch pixel space on asahi
    ];
  };

  # Autologin
  services.getty.autologinUser = "alex";
  environment.loginShellInit = ''
    [[ "$(tty)" == /dev/tty1 ]] && sway
  '';

  # Swap
  swapDevices = [{
    device = "/swapfile";
    size = 16 * 1024;
  }];

  # Environment
  environment = {
    sessionVariables = {
      # Wayland Support
      NIXOS_OZONE_WL = "1";
      MOZ_ENABLE_WAYLAND = "1";
      XDG_CURRENT_DESKTOP = "sway";
      XDG_SESSION_TYPE = "wayland";
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";

      # Theme
      GTK_THEME = "Adwaita-dark";

      # Nixpkgs
      NIXPKGS_ALLOW_UNFREE = "1";
      NIXPKGS_ALLOW_INSECURE = "1";
    };
    defaultPackages = lib.mkForce [];
  };
  
  # Modules
  modules = {

    # Network
    networkmanager.enable = true;
    bluetooth.enable = true;

    pipewire.enable = true; ## this will install easyeffects with its plugins

    systemd-boot.enable = true;
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
  system.stateVersion = "24.11";
}