{pkgs, ...}: let

  mesa-stable = import (fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/70b3172dc581d6b0107453ed4d0b22a85ebb57c4.tar.gz";
    sha256 = "1wsf7b89lnb0hcd4ccnjm39xv5f4g1bl4qm5zzfvmzcplvlmjyly";
  }) { inherit (pkgs) system; config = {}; };
  
in {

  hardware.graphics.package = mesa-stable.mesa;
  hardware.graphics.package32 = mesa-stable.pkgsi686Linux.mesa;

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
      # Allow backlight control for non-root users.
      ACTION=="add", SUBSYSTEM=="backlight", KERNEL=="apple-panel-bl", RUN+="${pkgs.coreutils}/bin/chmod 0664 /sys/class/backlight/apple-panel-bl/brightness"
    '';
  };

  hardware.keyboard.qmk.enable = true;

  # Disable power button (short press) and sleep/suspend button.
  services.logind.settings.Login = {
    HandlePowerKey = "ignore";
    HandleSuspendKey = "ignore";
    HandleHibernateKey = "ignore";
  };

  boot = {
    kernelParams = [
      # Enables the pixels horizontal of the notch.
      # Note that apple_dcp has been renamed to appledrm.
      "appledrm.show_notch=1"

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
      "vm.swappiness" = 15;
      "vm.vfs_cache_pressure" = 50;

    };
  };

  # Nautilus trash support.
  services.gvfs.enable = true;

  swapDevices = [
    {
      device = "/swapfile";
      size = 8 * 1024;
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
        command = "start-hyprland";
        user = "alex";
      };
    };
  };


  programs.hyprland = {
    enable = true;
    withUWSM = false;
  };

  environment = {
    sessionVariables = {
      NIXOS_OZONE_WL = "1";
      MOZ_ENABLE_WAYLAND = "1";
      XDG_SESSION_TYPE = "wayland";
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";

      AQ_DRM_DEVICES = "/dev/dri/card1";
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
        ids = ["*"]; # Apply to all keyboards
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
    keyd.enable = true;
    xampp.enable = true;

    bluetooth.enable = true;
  };

  # Did you read the comment?
  system.stateVersion = "24.11";
}
