{pkgs, ...}: {
  imports = [
    ../../hardware/jet
  ];

  networking.hostName = "jet";

  users.users = {
    alex = {
      isNormalUser = true;
      extraGroups = ["networkmanager" "wheel" "video" "audio" "dialout"];
      shell = pkgs.fish;
      hashedPassword = "$6$qRDf73LqqlnrtGKd$fwNbmyhVjAHfgjPpM.Wn8YoYVbLRq1oFWN15fjP3b.cVW8Dv3s/7q8NY4WBYY7x1Xe71S.AHpuqL1PY6IJe0x1";
    };
  };

  programs.fish.enable = true;

  hardware = {
    graphics = {
      enable = true;
    };
    asahi = {
      setupAsahiSound = true;
      peripheralFirmwareDirectory = ../../hardware/jet/firmware;
    };
  };

  services.udev = {
    extraRules = ''
      # Allow backlight control for non-root users.
      ACTION=="add", SUBSYSTEM=="backlight", KERNEL=="apple-panel-bl", RUN+="${pkgs.coreutils}/bin/chmod 0664 /sys/class/backlight/apple-panel-bl/brightness"
    '';
  };

  boot = {
    kernelParams = [
      # Enables the pixels horizontal of the notch.
      "apple_dcp.show_notch=1"

      # Default on asahi fedora.
      "zswap.enabled=1"
      "zswap.compressor=lz4"
      "zswap.zpool=z3fold"

      # Quiet boot.
      "quiet"
      "splash"
      "vt.global_cursor_default=0"
      "systemd.show_status=false"
      "udev.log_level=3"
    ];
    kernel.sysctl = {
      # Required by intellij idea.
      "kernel.perf_event_paranoid" = 1;
      "kernel.kptr_restrict" = 0;

      # Default on asahi fedora.
      "vm.swappiness" = 60;
    };
    consoleLogLevel = 3;
    initrd.verbose = false;
    initrd.systemd.enable = true;
    kernel.sysctl = {
      "kernel.printk" = "0 0 0 0";
    };
  };

  swapDevices = [
    {
      device = "/swapfile";
      # Default on asahi fedora.
      size = 12 * 1024;
    }
  ];

  # Autologin and hide getty messages.
  services.getty = {
    autologinUser = "alex";
    extraArgs = [
      "--skip-login"
      "--nonewline"
      "--noissue"
      "--noclear"
      "--nohostname"
    ];
  };

  # Automatically launch UWSM after login.
  environment.loginShellInit = ''
    [[ "$(tty)" == /dev/tty1 ]] && exec uwsm start default >/dev/null 2>&1
  '';
  
  security.pam.services.hyprlock = {};

  programs.hyprland = {
    enable = true;
    withUWSM = true;
  };

  environment = {
    sessionVariables = {
      WLR_DRM_DEVICES = "/dev/dri/card0";
      NIXOS_OZONE_WL = "1";
      MOZ_ENABLE_WAYLAND = "1";
      XDG_SESSION_TYPE = "wayland";
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    };
  };

  modules = {
    core.enable = true;
    dbus.enable = true;
    fontconfig.enable = true;
    keyring.enable = true;
    nh.enable = true;
    sudo-rs.enable = true;
    systemd-boot.enable = true;
    xdg.enable = true;
  };

  # Did you read the comment?
  system.stateVersion = "24.11";
}
