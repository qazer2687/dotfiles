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
    ];
  };

  environment.loginShellInit = ''
    [[ "$(tty)" == /dev/tty1 ]] && exec niri-session
  '';
  
  swapDevices = [
    {
      device = "/swapfile";
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
