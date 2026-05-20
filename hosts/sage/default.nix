{
  pkgs,
  inputs,
  lib,
  ...
}: {
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
      #"quiet"
      #"splash"
      #"vt.global_cursor_default=0"
      #"systemd.show_status=false"
      #"udev.log_level=3"
      #"console=/dev/null"

      # Disable both hardware and software watchdog.
      "nmi_watchdog=0"
      "nowatchdog"

      # Can help IRQ handling distribution and reduce latency under mixed load.
      "threadirqs"

      # Full preempt is enabled by my current cachy kernel but should be a flag if the kernel is not using it by default.

      # Prevents performance hits/stuttering.
      "split_lock_detect=off"
    ];
    # Disable WiFi driver.
    blacklistedKernelModules = [ "mt7921e" ];
    #consoleLogLevel = 3;
    #initrd.verbose = false;

    # Kernel panics without this option enabled.
    initrd.systemd.enable = true;
    
    kernel.sysctl = {
      # Quiet boot.
      #"kernel.printk" = "0 0 0 0";

      "vm.max_map_count" = 2147483642;

      # Low swappiness as I have enough ram to prioritise it aggressively.
      "vm.swappiness" = "1";

      # Queue discipline algorithm for traffic control (CAKE reduces bufferbloat and latency).
      "net.core.default_qdisc" = "cake";

      # TCP congestion control algorithm (BBR provides better throughput and lower latency).
      "net.ipv4.tcp_congestion_control" = "bbr";
    };
    kernelPackages = inputs.nix-cachyos-kernel.legacyPackages.x86_64-linux.linuxPackages-cachyos-latest;
  };

  # Use the "Latency-criticality Aware Virtual Deadline" scheduler for lower latency.
  services.scx = {
    enable = true;
    scheduler = "scx_lavd";
  };

  # This host enables amd_pstate/EPP which means that schedutil is not exposed
  # as a governor and the system defaults to powersave. I set the performance governer to
  # bias EPP towards performance.
  powerManagement.cpuFreqGovernor = "performance";

  services.udev = {
    extraRules = ''
      # ESP32-CYD2USB Support
      SUBSYSTEM=="tty", ATTRS{idVendor}=="1a86", ATTRS{idProduct}=="7523", SYMLINK+="ttyUSB0", MODE="0666", GROUP="dialout"

      # Boxflat Moza Support
      # TAG+="uaccess" does not work in extraRules.
      # https://github.com/NixOS/nixpkgs/issues/308681.
      SUBSYSTEM=="tty", KERNEL=="ttyACM*", ATTRS{idVendor}=="346e", ACTION=="add", MODE="0666"


      # Vial Support
      KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{serial}=="*vial:f64c2b3c*", MODE="0660", GROUP="users", TAG+="uaccess", TAG+="udev-acl"
    '';
    packages = [
      pkgs.platformio-core
      pkgs.openocd
    ];
  };

  systemd.settings.Manager.DefaultLimitNOFILE = "524288";
  security.pam.loginLimits = [
    # Esync compatibility.
    {
      domain = "alex";
      type = "hard";
      item = "nofile";
      value = "524288";
    }
    # Real-Time Priortiy
    {
      domain = "alex";
      type = "-";
      item = "rtprio";
      value = "99";
    }
  ];

  systemd.network.wait-online.enable = false;
  systemd.services.NetworkManager-wait-online.enable = false;

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
        command = "niri-session";
        user = "alex";
      };
    };
  };

  hardware.graphics = {
    enable = true;
    package = (pkgs.mesa.overrideAttrs (old: {
      patches = old.patches ++ [
        (pkgs.fetchpatch {
          url = "https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/41680.patch";
          sha256 = "sha256-u9gPoRA2OMx6OCCwyNhclmx6pRe7a7d7y21e16q9/Tg=";
        })
      ];
    }));
    package32 = (pkgs.pkgsi686Linux.mesa.overrideAttrs (old: {
      patches = old.patches ++ [
        (pkgs.fetchpatch {
          url = "https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/41680.patch";
          sha256 = "sha256-u9gPoRA2OMx6OCCwyNhclmx6pRe7a7d7y21e16q9/Tg=";
        })
      ];
    }));
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
      AMD_VULKAN_ICD = "RADV";

      # Use qwerty inside of gamescope sessions. Set via lutris environment variables to enable per-game colemak.
      XKB_DEFAULT_LAYOUT = "us";
      #XKB_DEFAULT_VARIANT = "colemak";
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
    keyd.enable = true;

    # Gaming
    gamemode.enable = true;
    pipewire.enable = true;
    steam.enable = true;
    amdgpu.enable = true;
    flatpak.enable = true;
    gamescope.enable = true;
    opentrack.enable = true;

    # AI
    ollama.enable = true;
  };

  programs.nix-ld.enable = true;
  virtualisation.docker.enable = true;

  # Did you read the comment?
  system.stateVersion = "25.05";
}
