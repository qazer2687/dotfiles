{pkgs, ...}: {
  imports = [
    ../../hardware/mica
    ../../modules/nixos
  ];

  networking.hostName = "mica";

  users.users.alex = {
    isNormalUser = true;
    extraGroups = ["networkmanager" "wheel" "video"];
    hashedPassword = "$6$qRDf73LqqlnrtGKd$fwNbmyhVjAHfgjPpM.Wn8YoYVbLRq1oFWN15fjP3b.cVW8Dv3s/7q8NY4WBYY7x1Xe71S.AHpuqL1PY6IJe0x1";
    shell = pkgs.fish;
  };

  programs.fish.enable = true;

  boot = {
    kernelParams = [
      "quiet"
      "mitigations=off"

      # Enable Intel GuC/HuC
      "i915.enable_guc=3"

      # https://wiki.cachyos.org/configuration/general_system_tweaks/?utm_source=chatgpt.com#enable-rcu-lazy
      "rcutree.enable_rcu_lazy=1"
    ];
    blacklistedKernelModules = [
      # Disable the watchdog timer to stop
      # watchdog from hanging on poweroff.
      "iTCO_wdt"
      # Wi-Fi
      "iwlwifi"
      # Bluetooth
      "btusb"
    ];
    initrd.verbose = false;
    consoleLogLevel = 0;
    # Support for my external HDD.
    supportedFilesystems = ["exfat"];
    #kernelPackages = pkgs.linuxPackages_cachyos;
  };

  # CPU usage too high with this enabled.
  # services.scx.enable = true;

  # Prevent log files from becoming too large.
  services.journald.extraConfig = ''
    SystemMaxUse=100M
  '';

  networking.firewall = {
    enable = true;
    # I use a reverse proxy for everything but these things require ports to be open.
    allowedTCPPorts = [
      # Caddy
      80
      81
      443
      # qBittorrent
      6881
      # Conduwuit (Matrix)
      8448
    ];
    allowedUDPPorts = [
      # qBittorrent
      6881
    ];
  };

  # Mount the external HDD.
  fileSystems."/mnt/external" = {
    device = "/dev/sda1";
    fsType = "exfat";
    options = ["umask=0000" "nofail"];
    noCheck = true;  # This disables fsck
  };

  # Bind my media directory to the external HDD.
  fileSystems."/home/alex/media" = {
    device = "/mnt/external/media";
    options = ["bind"];
  };

  # Spin down the external HDD after 10 minutes of inactivity.
  systemd.services.hdparm = {
    description = "/dev/sda Spin Down ";
    wantedBy = ["multi-user.target"];
    after = ["local-fs.target"];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.hdparm}/bin/hdparm -S 60 /dev/sda";
    };
  };

  # For vscode server until I configure the vscode server flake:
  # https://github.com/nix-community/nixos-vscode-server.
  programs.nix-ld.enable = true;
  # Zed has a server option in the home manager module
  # so if that works I can remove this.

  modules = {
    core.enable = true;
    systemd-boot.enable = true;
    zram.enable = true;
    tailscale.enable = true;
    docker.enable = true;
    samba.enable = true;
  };

  # Did you read the comment?
  system.stateVersion = "25.05";
}
