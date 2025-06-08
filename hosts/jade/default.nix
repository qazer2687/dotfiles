{pkgs, ...}: {
  imports = [
    ../../hardware/jade
    ../../modules/nixos
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

  hardware = {
    graphics = {
      enable = true;
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
    # I don't remember exactly why this is needed but
    # I'm unable to rebuild without this option set.
    # loader.efi.efiSysMountPoint = "/boot/efi";
    kernelParams = [
      "kernel.nmi_watchdog=0"
      "bgrt_disable"
      "rd.systemd.show_status=false"
      "rd.udev.log_level=0"
      "udev.log_priority=3"
      "mitigations=off"
      # A workaround for wine not being able to use SIDT instructions,
      # this kernel flag disables UMIP. See link below for more info.
      # https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/arch/x86/include/asm/cpufeatures.h?h=v5.2.5#n324
      "clearcpuid=514"
      "quiet"
      # Redirect console messages.
      "console=tty3"
      # Disable cursor to stop blinking.
      "vt.global_cursor_default=0"
      # Wipe the vendor logo earlier in the boot sequence.
      "fbcon=nodefer"
    ];
    initrd.kernelModules = [
      "nvidia"
      "nvidia_modeset"
      "nvidia_uvm"
      "nvidia_drm"
    ];
    blacklistedKernelModules = [
      "nouveau"
    ];
    # EXPERIMENTAL - These sysctl options are for
    # improving performance and stuff idk.
    kernel.sysctl = {
      "vm.dirty_background_ratio" = 5;
      "vm.dirty_ratio" = 10;
      # The received frames will be stored in this queue after taking
      # them from the ring buffer on the network card. Increasing this
      # value for high speed cards may help prevent losing packets.
      "net.core.netdev_max_backlog" = 16384;
      # TCP Fast Open is an extension to the transmission control protocol
      # that helps reduce network latency by enabling data to be exchanged
      # during the sender’s initial TCP SYN. Using the value 3 allows TCP
      # Fast Open for both incoming and outgoing connections.
      "net.ipv4.tcp_fastopen" = 3;
      # The BBR congestion control algorithm can help achieve higher
      # bandwidths and lower latencies for internet traffic.
      "net.core.default_qdisc" = "cake";
      "net.ipv4.tcp_congestion_control" = "bbr";
    };
    initrd.verbose = false;
    consoleLogLevel = 0;
    # Compiles from source.
    #kernelPackages = pkgs.linuxPackages_cachyos;
    kernelPackages = pkgs.linuxPackages_xanmod;
  };

  # EXPERIMENTAL - Enable realtime priority
  # to improve latency and reduce stuttering.
  security.pam.loginLimits = [
    {
      domain = "@users";
      item = "rtprio";
      type = "-";
      value = 1;
    }
  ];

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
  
  # Launch DWL after autologin.
  environment.loginShellInit = ''
    [[ "$(tty)" == /dev/tty1 ]] && dwl
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
      # This option scales menu bars, causing
      # them to appear way too large.
      # GDK_SCALE = "2";
    };
  };
  
  modules = {
    core.enable = true;
    nvidia.enable = true;
    pipewire.enable = true;
    systemd-boot.enable = true;
    steam.enable = true;
    xdg.enable = true;
    #zram.enable = true;
    zswap.enable = true;
    gamemode.enable = true;
    tailscale.enable = true;
  };

  # Did you read the comment?
  system.stateVersion = "25.05";
}
