{
  config,
  pkgs,
  ...
}: {
  imports = [
    ../../hardware/jade
    ../../modules/nixos
  ];

  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };

  # Hostname
  networking.hostName = "jade";

  # User
  users.users = {
    alex = {
      initialPassword = "xela";
      isNormalUser = true;
      openssh.authorizedKeys.keys = [
        # TODO: Add your SSH public key(s) here...
      ];
      extraGroups = ["networkmanager" "wheel" "video" "audio"];
      shell = pkgs.fish;
    };
  };

  # Shell
  programs.fish.enable = true;

  # Hardware
  hardware = {
    graphics = {
      enable = true;
    };
  };

  # Boot
  boot = {
    ## I don't remember exactly why this is needed but
    ## I'm unable to rebuild without this option set.
    loader.efi.efiSysMountPoint = "/boot/efi";
    kernelParams = [
      "kernel.nmi_watchdog=0"
      "fbcon=nodefer"
      "bgrt_disable"
      "quiet"
      "rd.systemd.show_status=false"
      "rd.udev.log_level=0"
      "udev.log_priority=3"
      "vt.global_cursor_default=0"
      "mitigations=off"
      ## A workaround for wine not being able to use SIDT instructions,
      ## this kernel flag disables UMIP. See link below for more info.
      ## https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/arch/x86/include/asm/cpufeatures.h?h=v5.2.5#n324
      "clearcpuid=514"
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
    ## EXPERIMENTAL - These sysctl options are for
    ## improving performance whilst running games.
    kernel.sysctl = {
      "vm.dirty_background_ratio" = 5;
      "vm.dirty_ratio" = 10;
      ## The received frames will be stored in this queue after taking
      ## them from the ring buffer on the network card. Increasing this
      ## value for high speed cards may help prevent losing packets.
      "net.core.netdev_max_backlog" = 16384;
      ## TCP Fast Open is an extension to the transmission control protocol
      ## that helps reduce network latency by enabling data to be exchanged
      ## during the sender’s initial TCP SYN. Using the value 3 allows TCP
      ## Fast Open for both incoming and outgoing connections.
      "net.ipv4.tcp_fastopen" = 3;
      ## The BBR congestion control algorithm can help achieve higher
      ## bandwidths and lower latencies for internet traffic.
      "net.core.default_qdisc" = "cake";
      "net.ipv4.tcp_congestion_control" = "bbr";
    };
    initrd.verbose = false;
    consoleLogLevel = 0;
    kernelPackages = pkgs.linuxPackages_xanmod;
  };

  ## EXPERIMENTAL - This service distributes CPU interrupts
  ## across all cores, supposedly improving performance.
  services.irqbalance.enable = true;

  ## EXPERIMENTAL - Enable realtime priority
  ## to improve latency and reduce stuttering.
  security.pam.loginLimits = [{
    domain = "@users"; item = "rtprio"; type = "-"; value = 1;
  }];

  # Autologin
  services.getty.autologinUser = "alex";
  environment.loginShellInit = ''
    [[ "$(tty)" == /dev/tty1 ]] && startx
  '';

  # Swap
  swapDevices = [
    {
      device = "/swapfile";
      size = 16 * 1024;
    }
  ];

  # Environment
  environment = {
    sessionVariables = {
      GTK_THEME = "Adwaita-dark";
    };
  };

  # X Server
  services.xserver = {
    enable = true;
    displayManager.startx.enable = true;
  };

  # Modules
  modules = {
    core.enable = true;
    networkmanager.enable = true;
    nvidia.enable = true;
    pipewire.enable = true;
    systemd-boot.enable = true;
    steam.enable = true;
    filesystem.enable = true;
    fonts.enable = true;
    keymap.enable = true;
    zram.enable = true;
    gamemode.enable = true;
    nh.enable = true;
  };

  # SOPS
  sops.defaultSopsFile = ./secrets/default.yaml;

  # Locale
  time.timeZone = "Europe/London";
  i18n.defaultLocale = "en_GB.UTF-8";

  # Did you read the comment?
  system.stateVersion = "23.05";
}
