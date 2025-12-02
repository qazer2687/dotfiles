{pkgs, ...}: {
  imports = [
    ../../hardware/sage
  ];

  networking.hostName = "sage";

  users.users = {
    alex = {
      isNormalUser = true;
      extraGroups = ["networkmanager" "wheel" "video" "audio" "dialout"];
      shell = pkgs.fish;
      hashedPassword = "$6$qRDf73LqqlnrtGKd$fwNbmyhVjAHfgjPpM.Wn8YoYVbLRq1oFWN15fjP3b.cVW8Dv3s/7q8NY4WBYY7x1Xe71S.AHpuqL1PY6IJe0x1";
    };
  };

  programs.fish.enable = true;

  boot = {
    kernelParams = [
      # Quiet boot.
      "quiet"
      "splash"
      "vt.global_cursor_default=0"
      "systemd.show_status=false"
      "udev.log_level=3"
      "console=/dev/null"
    ];
    consoleLogLevel = 3;
    initrd.verbose = false;
    # Kernel panic without this option enabled.
    initrd.systemd.enable = true;
    kernel.sysctl = {
      # Quiet boot.
      "kernel.printk" = "0 0 0 0";

      # Queue discipline algorithm for traffic control (CAKE reduces bufferbloat and latency).
      "net.core.default_qdisc" = "cake";

      # TCP congestion control algorithm (BBR provides better throughput and lower latency).
      "net.ipv4.tcp_congestion_control" = "bbr";
    };
    kernelPackages = pkgs.linuxPackages_cachyos;
    supportedFilesystems = [ "ntfs" ];
  };

  #services.scx = {
  #  enable = true;
  #  scheduler = "scx_lavd";
  #};

  services.udev = {
    extraRules = ''
    # ESP32-CYD2USB Support
    SUBSYSTEM=="tty", ATTRS{idVendor}=="1a86", ATTRS{idProduct}=="7523", SYMLINK+="ttyUSB0", MODE="0666", GROUP="dialout"
    '';
    packages = [
      pkgs.platformio-core
      pkgs.openocd
    ];
  };

  # Enable esync compatibility.
  systemd.settings.Manager.DefaultLimitNOFILE = "524288";
  security.pam.loginLimits = [{
    domain = "alex";
    type = "hard";
    item = "nofile";
    value = "524288";
  }];

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
      AMD_VULKAN_ICD = "RADV";

      # Picked up by gamescope session.
      XKB_DEFAULT_LAYOUT = "us";
      XKB_DEFAULT_VARIANT = "colemak";
    };
    # Required for nix-flatpak to work. Not in home-manager because of gmodena/nix-flatpak#33.
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
    easyeffects.enable = true;

    # Gaming
    gamemode.enable = true;
    pipewire.enable = true;
    steam.enable = true;
    amdgpu.enable = true;
    flatpak.enable = true;
    gamescope.enable = true;

    # AI
    #ollama.enable = true;
  };

  # Did you read the comment?
  system.stateVersion = "25.05";
}
