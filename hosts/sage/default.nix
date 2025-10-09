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
    ];
    consoleLogLevel = 3;
    initrd.verbose = false;
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

  services.scx = {
    enable = true;
    scheduler = "scx_lavd";
  };

  services.udev = {
    # ESP32-CYD2USB Support
    extraRules = ''
      SUBSYSTEM=="tty", ATTRS{idVendor}=="1a86", ATTRS{idProduct}=="7523", SYMLINK+="ttyUSB0", MODE="0666", GROUP="dialout"
    '';
    packages = [
      pkgs.platformio-core
      pkgs.openocd
    ];
  };

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
      NIXOS_OZONE_WL = "1";
      MOZ_ENABLE_WAYLAND = "1";
      XDG_SESSION_TYPE = "wayland";
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    };
    # Required for nix-flatpak to work. Not in home-manager because of gmodena/nix-flatpak#33.
    systemPackages = [pkgs.flatpak];
  };

  # Roblox - Not in home-manager because of gmodena/nix-flatpak#33.
  services.flatpak = {
    enable = true;
    update.onActivation = true;
    packages = [
      "org.vinegarhq.Sober"
      # Broken
      "org.vinegarhq.Vinegar"
    ];
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

    # Gaming
    gamemode.enable = true;
    pipewire.enable = true;
    steam.enable = true;
    amdgpu.enable = true;
  };

  # Did you read the comment?
  system.stateVersion = "25.05";
}
