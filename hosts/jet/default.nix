{
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ../../hardware/jet
    ../../modules/nixos
  ];

  # Hostname
  networking.hostName = "jet";

  # User
  users.users = {
    alex = {
      initialPassword = "xela";
      isNormalUser = true;
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
    asahi = {
      withRust = true;
      useExperimentalGPUDriver = true;
      ## Using the driver mode breaks sway and using the 
      ## overlay mode fails to compile so I can only use
      ## the replace mode, but it makes my config impure.
      experimentalGPUInstallMode = "replace";
      setupAsahiSound = true;
      peripheralFirmwareDirectory = ../../firmware/jet;
    };
  };

  # Boot
  boot = {
    kernelParams = [
      "apple_dcp.show_notch=1" ## Enables the pixels horizontal of the notch.
      "kernel.nmi_watchdog=0"
      "fbcon=nodefer"
      "bgrt_disable"
      "quiet"
      "rd.systemd.show_status=false"
      "rd.udev.log_level=0"
      "udev.log_priority=3"
      "console=tty3"
      "vt.global_cursor_default=0"
      "mitigations=off"
    ];
    initrd.verbose = false;
    consoleLogLevel = 0;
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
      NIXOS_OZONE_WL = "1";
      MOZ_ENABLE_WAYLAND = "1";
      XDG_CURRENT_DESKTOP = "sway";
      XDG_SESSION_TYPE = "wayland";
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
      GTK_THEME = "Adwaita-dark";
    };
  };

  # Modules
  modules = {
    core.enable = true;
    networkmanager.enable = true;
    bluetooth.enable = true;
    ## Sound is managed via the setupAsahiSound option
    ## and I do not need easyeffects installed on Jet.
    ## pipewire.enable = true;
    systemd-boot.enable = true;
    filesystem.enable = true;
    fonts.enable = true;
    keymap.enable = true;
    zram.enable = true;
    nh.enable = true;
  };

  # Did you read the comment?
  system.stateVersion = "24.11";
}
