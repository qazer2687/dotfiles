{
  lib,
  config,
  pkgs,
  self,
  ...
}: {
  imports = [
    ../../hardware/jet
    ../../hardware/jet/apple-silicon-support
    ../../modules/nixos
  ];

  nixpkgs = {
    config = {
      allowUnfree = true;
    };
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
      shell = self.packages.fish;
    };
  };

  # Shell
  programs.fish.enable = true;

  # Dconf
  programs.dconf.enable = true;

  # Hardware
  hardware = {
    graphics = {
      enable = true;
    };
    # Asahi
    asahi = {
      withRust = true;
      useExperimentalGPUDriver = true;
      experimentalGPUInstallMode = "replace"; ## driver breaks sway, overlay fails to compile, replace doesn't work in pure eval
      setupAsahiSound = true;
      peripheralFirmwareDirectory = ../../firmware/jet;
    };
  };

  # Boot
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
  swapDevices = [
    {
      device = "/swapfile";
      size = 16 * 1024;
    }
  ];

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
    # Core
    nix.enable = true;

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
