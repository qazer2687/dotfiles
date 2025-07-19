{pkgs, ...}: {
  imports = [
    ../../hardware/jade
  ];

  networking.hostName = "jade";

  users.users = {
    alex = {
      isNormalUser = true;
      extraGroups = ["networkmanager" "wheel" "video" "audio"];
      shell = pkgs.fish;
      hashedPassword = "$6$qRDf73LqqlnrtGKd$fwNbmyhVjAHfgjPpM.Wn8YoYVbLRq1oFWN15fjP3b.cVW8Dv3s/7q8NY4WBYY7x1Xe71S.AHpuqL1PY6IJe0x1";
    };
  };

  programs.fish.enable = true;

  services.udev = {
    extraRules = ''
      # Enable support for the ESP32-CYD2USB.
      SUBSYSTEM=="tty", ATTRS{idVendor}=="1a86", ATTRS{idProduct}=="7523", SYMLINK+="ttyUSB0", MODE="0666", GROUP="dialout"
    '';
  };

  boot = {
    kernelParams = [
      "mitigations=off"
    ];
    kernel.sysctl = {
      # How aggressively the kernel will swap memory pages (0-100, lower values prefer RAM over swap).
      "vm.swappiness" = 15;
      
      # Queue discipline algorithm for traffic control (CAKE reduces bufferbloat and latency).
      "net.core.default_qdisc" = "cake";
      
      # TCP congestion control algorithm (BBR provides better throughput and lower latency).
      "net.ipv4.tcp_congestion_control" = "bbr";
    };
    initrd.verbose = false;
    consoleLogLevel = 0;
    # EXPERIMENTAL - Use the cachyos kernel.
    kernelPackages = pkgs.linuxPackages_cachyos;
  };

  /*
  # EXPERIMENTAL - Use the scx_lavd scheduler.
  services.scx = {
    enable = true;
    scheduler = "scx_lavd";
  };
  */

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
      # EXERIMENTAL - I don't know what a good value is.
      # Setting it high just makes it fill up and thrash.
      # My swappiness isn't even high.
      size = 4 * 1024;
    }
  ];

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
    ];
  };

  modules = {
    core.enable = true;
    zram.enable = true;

    # Gaming
    #ananicy.enable = true;
    gamemode.enable = true;
    gamescope.enable = true;
    nvidia.enable = true;
    pipewire.enable = true;
    steam.enable = true;
  };

  # Did you read the comment?
  system.stateVersion = "25.05";
}
