{pkgs, inputs, ...}: {
  imports = [
    ../../hardware/ivy
  ];

  networking.hostName = "ivy";

  users.users = {
    alex = {
      isNormalUser = true;
      extraGroups = ["networkmanager" "wheel" "video" "audio" "dialout"];
      shell = pkgs.fish;
      hashedPassword = "$6$qRDf73LqqlnrtGKd$fwNbmyhVjAHfgjPpM.Wn8YoYVbLRq1oFWN15fjP3b.cVW8Dv3s/7q8NY4WBYY7x1Xe71S.AHpuqL1PY6IJe0x1";
    };
  };

  programs.fish.enable = true;

  # Disable power button (short press) and sleep/suspend button.
  services.logind.settings.Login = {
    HandlePowerKey = "ignore";
    HandleSuspendKey = "ignore";
    HandleHibernateKey = "ignore";
  };

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    kernelParams = [
      "mitigations=off"
      "i915.enable_guc=3"
      "i915.fastboot=1"
      "i915.enable_dc=0"
      "i915.enable_psr=0"
      "psmouse.synaptics_intertouch=1"
    ];
  };

  # Nautilus trash support.
  services.gvfs.enable = true;

  swapDevices = [
    {
      device = "/swapfile";
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

  services.udev = {
    extraRules = ''
      # Allow backlight control for non-root users.
      ACTION=="add", SUBSYSTEM=="backlight", KERNEL=="apple-panel-bl", RUN+="${pkgs.coreutils}/bin/chmod 0664 /sys/class/backlight/apple-panel-bl/brightness"
    '';
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
    flatpak.enable = true;
    keyd.enable = true;
    pipewire.enable = true;
    tlp.enable = true;
    easyeffects.enable = true;
  };

  # Did you read the comment?
  system.stateVersion = "24.11";
}
