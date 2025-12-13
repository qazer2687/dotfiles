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

  hardware.graphics.package =
    # Workaround for Mesa 25.3.0 regression
    # https://github.com/nix-community/nixos-apple-silicon/issues/380
    assert pkgs.mesa.version == "25.3.0";
    (import (fetchTarball {
      url = "https://github.com/NixOS/nixpkgs/archive/c5ae371f1a6a7fd27823bc500d9390b38c05fa55.tar.gz";
      sha256 = "sha256-4PqRErxfe+2toFJFgcRKZ0UI9NSIOJa+7RXVtBhy4KE=";
  }) { localSystem = pkgs.stdenv.hostPlatform; }).mesa;

  services.udev = {
    extraRules = ''
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
      "apple_dcp.show_notch=1"

      "zswap.enabled=1"

      # Quiet boot.
      #"quiet"
      #"splash"
      #"vt.global_cursor_default=0"
      #"systemd.show_status=false"
      #"udev.log_level=3"
    ];
    kernel.sysctl = {
      # Default is 60 but too swappy for my liking.
      "vm.swappiness" = 100;
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
    systemPackages = [pkgs.flatpak];
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
    networkmanager.enable = true;
    tailscale.enable = true;
    platformio.enable = true;
    easyeffects.enable = true;
    flatpak.enable = true;
  };

  # Did you read the comment?
  system.stateVersion = "24.11";
}
