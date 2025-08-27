{pkgs, ...}: {
  imports = [
    ../../hardware/jet
  ];

  networking.hostName = "jet";

  users.users = {
    alex = {
      isNormalUser = true;
      extraGroups = ["networkmanager" "wheel" "video" "audio" "dialout" "docker"];
      shell = pkgs.fish;
      hashedPassword = "$6$qRDf73LqqlnrtGKd$fwNbmyhVjAHfgjPpM.Wn8YoYVbLRq1oFWN15fjP3b.cVW8Dv3s/7q8NY4WBYY7x1Xe71S.AHpuqL1PY6IJe0x1";
    };
  };
  
  hardware = {
    graphics = {
      enable = true;
    };
    asahi = {
      setupAsahiSound = true;
      peripheralFirmwareDirectory = ../../firmware/jet;
    };
  };

  services.udev = {
    extraRules = ''
      # Enable support for the ESP32-CYD2USB.
      SUBSYSTEM=="tty", ATTRS{idVendor}=="1a86", ATTRS{idProduct}=="7523", SYMLINK+="ttyUSB0", MODE="0666", GROUP="dialout"

      # Allow backlight control for non-root users.
      ACTION=="add", SUBSYSTEM=="backlight", KERNEL=="apple-panel-bl", RUN+="${pkgs.coreutils}/bin/chmod 0664 /sys/class/backlight/apple-panel-bl/brightness"
    '';
  };

  boot = {
    kernelParams = [
      # Enables the pixels horizontal of the notch.
      "apple_dcp.show_notch=1"
      "quiet"
      # Redirect console messages.
      "console=tty3"
      # Disable cursor to stop blinking.
      "vt.global_cursor_default=0"
      # Wipe the vendor logo earlier in the boot sequence.
      "fbcon=nodefer"
    ];
    blacklistedKernelModules = [
      # Disable the watchdog timer to stop
      # watchdog from hanging on poweroff.
      "iTCO_wdt"
      # Bluetooth
      "btusb"
    ];
    initrd.verbose = false;
    consoleLogLevel = 0;
    m1n1CustomLogo = ../../assets/m1n1CustomLogo_kagami.png;
  };

  # Hide the 'File descriptor leaked on LVM invocation' warning on boot.
  environment.etc."lvm/lvm.conf".text = ''
    devices {
        suppress_fd_warnings = 1;
    }
    logging {
        level = 0;
    }
  '';

  # Autologin and hide getty messages.
  services.getty = {
    autologinUser = "alex";
    extraArgs = [
      "--skip-login"
      "--nonewline"
      "--noissue"
      "--noclear"
    ];
  };

  programs.hyprland = {
    enable = true;
    withUWSM = true;
  };

  # Automatically launch UWSM after login.
  environment.loginShellInit = ''
    [[ "$(tty)" == /dev/tty1 ]] && exec uwsm start default
  '';
  
  swapDevices = [
    {
      device = "/swapfile";
      # 1x RAM
      size = 8 * 1024;
    }
  ];

  environment = {
    sessionVariables = {
      NIXOS_OZONE_WL = "1";
      MOZ_ENABLE_WAYLAND = "1";
      XDG_SESSION_TYPE = "wayland";
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";

      # Temporary fix for nautilus not launching on hyprland.
      # https://bbs.archlinux.org/viewtopic.php?pid=2196562#p2196562
      GSK_RENDERER = "ngl";

      # Temporary fix for the cursor being offset slightly on hyprland.
      # https://github.com/hyprwm/Hyprland/issues/7244
      AQ_NO_ATOMIC = "0";
    };
  };

  modules = {
    core.enable = true;

    # Sound is managed via the setupAsahiSound option
    # and I do not need easyeffects installed on Jet.
    # pipewire.enable = true;

    # Marcan said something about it being ineffective on apple silicon.
    # zram.enable = true;
    
  };

  # Did you read the comment?
  system.stateVersion = "24.11";
}
