{
  lib,
  config,
  ...
}: {
  imports = [
    ../../hardware/jade
    ../../modules/nixos
  ];

  nixpkgs = {
    config = {
      allowUnfree = true;
    };
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

  # Dconf
  programs.dconf.enable = true;

  # Hardware
  hardware = {
    graphics = {
      enable = true;
    };
  };

  # Boot
  boot = {
    loader.efi.efiSysMountPoint = "/boot/efi"; #! Required for everything to not shit itself when I rebuild...
    kernelParams = [
      # TODO: Move kernelParams from module to here...
      "kernel.nmi_watchdog=0"
      "fbcon=nodefer"
      "bgrt_disable"
      "quiet"
      "rd.systemd.show_status=false"
      "rd.udev.log_level=0"
      "udev.log_priority=3"
      "vt.global_cursor_default=0"
      "mitigations=off"
    ];
    initrd.kernelModules = [
      "nvidia"
      "nvidia_modeset"
      "nvidia_uvm"
      "nvidia_drm"
    ];
    blacklistedKernelModules = [
      "nouveau"
    ];
    initrd.verbose = false;
    consoleLogLevel = 0;
    kernelPackages = pkgs.linuxPackages_xanmod;
  };

  # Autologin
  services.getty.autologinUser = "alex";
  environment.loginShellInit = ''
    [[ "$(tty)" == /dev/tty1 ]] && startx
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

  # Modules
  modules = {
    # Network
    networkmanager.enable = true;

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
