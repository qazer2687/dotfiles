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
    asahi = {
      enable = true;
      setupAsahiSound = true;
      peripheralFirmwareDirectory = ../../hardware/jet/firmware;
      extractPeripheralFirmware = true;
    };
  };
  
  services.udev = {
    extraRules = ''
      SUBSYSTEM=="input", ENV{ID_INPUT_KEYBOARD}=="1", ATTRS{id/bus}=="usb", ACTION=="add", \
          RUN+="/bin/echo 1 > /sys/devices/platform/i8042/serio0/input/input*/inhibited"
      SUBSYSTEM=="input", ENV{ID_INPUT_KEYBOARD}=="1", ATTRS{id/bus}=="usb", ACTION=="remove", \
          RUN+="/bin/echo 0 > /sys/devices/platform/i8042/serio0/input/input*/inhibited"
      # Allow backlight control for non-root users.
      ACTION=="add", SUBSYSTEM=="backlight", KERNEL=="apple-panel-bl", RUN+="${pkgs.coreutils}/bin/chmod 0664 /sys/class/backlight/apple-panel-bl/brightness"
    '';
  };

  # Disable power button (short press) and sleep/suspend button.
  services.logind.settings.Login = {
    HandlePowerKey = "ignore";
    HandleSuspendKey = "ignore";
    HandleHibernateKey = "ignore";
  };

  boot = {
    kernelParams = [
      # Enables the pixels horizontal of the notch.
      # Note that in a future upgrade apple_dcp is renamed to appledrm.
      "apple_dcp.show_notch=1"

      # zswap
      "zswap.enabled=1"
      "zswap.compressor=zstd"
      "zswap.zpool=zsmalloc"
      "zswap.max_pool_percent=50"
      "zswap.shrinker_enabled=1"

      # Quiet boot.
      #"quiet"
      #"splash"
      #"vt.global_cursor_default=0"
      #"systemd.show_status=false"
      #"udev.log_level=3"
    ];
    kernel.sysctl = {
      # Lower to stop thrashing.
      "vm.swappiness" = 40;
    };
  };
  
  # Nautilus trash support.
  services.gvfs.enable = true;

  swapDevices = [
    {
      device = "/swapfile";
      # Default on asahi fedora.
      size = 16 * 1024;
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
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "uwsm start default";
        user = "alex";
      };
    };
  };

  programs.hyprland = {
    enable = true;
    withUWSM = true;
  };

  environment = {
    sessionVariables = {
      NIXOS_OZONE_WL = "1";
      MOZ_ENABLE_WAYLAND = "1";
      XDG_SESSION_TYPE = "wayland";
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    };
    systemPackages = with pkgs; [
      flatpak
      nautilus
      ffmpegthumbnailer
      ffmpeg-headless
      gdk-pixbuf
    ];
  };

  environment.pathsToLink = [
    "share/thumbnailers"
  ];


  services.keyd = {
    enable = true;                                                            
      keyboards = {
        default = {
        ids = [ "*" ]; # Apply to all keyboards
        settings = {
          main = {
            # Tap for Escape, hold for Control
          capslock = "overload(control, esc)";
          };
        };
      };
    };
  };

  # Add this to your configuration.nix, inside the main set of options
  environment.etc."libinput/local-overrides.quirks".text = ''
    [Serial Keyboards]
    MatchUdevType=keyboard
    MatchName=keyd virtual keyboard
    AttrKeyboardIntegration=internal
  '';

  modules = {
    core.enable = true;
    dbus.enable = true;
    fontconfig.enable = true;
    keyring.enable = true;
    nh.enable = true;
    sudo-rs.enable = true;
    systemd-boot.enable = true;
    xdg.enable = true;
    networkmanager.enable = true;
    tailscale.enable = true;
    platformio.enable = true;
    easyeffects.enable = true;
    flatpak.enable = true;

    bluetooth.enable = true;
  };

  # Did you read the comment?
  system.stateVersion = "24.11";
}
