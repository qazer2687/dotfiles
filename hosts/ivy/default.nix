{pkgs, ...}: {
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
    kernelPackages = pkgs.linuxPackages_cachyos;
    kernelParams = [
      # Disables Spectre/Meltdown/MDS/etc mitigations
      # i5-8350U (8th gen): 10-15% performance gain, 5-8% on 10th gen+
      "mitigations=off"
      
      # GuC firmware submission + HuC auth for UHD 620
      # Offloads GPU scheduling to microcontroller
      # 2-5% improvement in GPU-bound scenarios, mandatory for Gen 9.5
      "i915.enable_guc=3"
      
      # Reduces boot time by 1-2s, no runtime impact
      "i915.fastboot=1"
      
      # Panel Self-Refresh causes 99th percentile frame time spikes
      # Disabling adds ~0.5W power draw on AC
      "i915.enable_psr=0"
      
      # madvise allows apps to request 2MB pages vs 4KB
      # Reduces TLB misses: 512 entries cover 1GB vs 2MB with hugepages
      # 3-7% improvement in memory-intensive games
      "transparent_hugepage=madvise"
    ];
    
    kernel.sysctl = {
      "vm.swappiness" = 10;
      
      # RX packet queue depth (default 1000)
      # Prevents packet drops during network bursts in online games
      "net.core.netdev_max_backlog" = 16384;
      
      # Enable TCP Fast Open for client and server
      # Eliminates 1 RTT on connection establishment
      "net.ipv4.tcp_fastopen" = 3;
      
      # CAKE qdisc: <5ms latency under load vs 200ms+ with default fq_codel
      # Critical for bufferbloat control during uploads
      "net.core.default_qdisc" = "cake";
      
      # inotify watch limit for Steam client (requires ~200k watches)
      "fs.inotify.max_user_watches" = 524288;
      
      # TCP congestion control algorithm (BBR provides better throughput and lower latency).
      "net.ipv4.tcp_congestion_control" = "bbr";
    };
  };

  services.scx = {
    enable = true;
    scheduler = "scx_lavd";
    extraArgs = [ "--performance" ];
  };

  services.throttled = {
    enable = true;
    extraConfig = ''
      [GENERAL]
      Enabled: True

      [AC]
      Update_Rate_s: 5
      PL1_TDP_W: 44
      PL2_TDP_W: 44
      Trip_Temp_C: 85

      [BATTERY]
      Update_Rate_s: 30
      PL1_TDP_W: 29
      PL2_TDP_W: 44
      Trip_Temp_C: 80
    '';
  };

  hardware.cpu.x86.msr.enable = true;

  hardware = {
    enableAllFirmware = true;
    graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
        intel-media-driver
        intel-vaapi-driver
      ];
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
    gamemode.enable = true;
    tlp.enable = false;
    easyeffects.enable = true;
  };

  # Did you read the comment?
  system.stateVersion = "24.11";
}
