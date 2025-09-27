{pkgs, ...}: {
  imports = [
    ../../hardware/mica
  ];

  networking.hostName = "mica";

  users = {
    mutableUsers = false;
    users = {
      root = {
        hashedPassword = "$6$qRDf73LqqlnrtGKd$fwNbmyhVjAHfgjPpM.Wn8YoYVbLRq1oFWN15fjP3b.cVW8Dv3s/7q8NY4WBYY7x1Xe71S.AHpuqL1PY6IJe0x1";
      };
      alex = {
        isNormalUser = true;
        extraGroups = ["networkmanager" "wheel" "video"];
        hashedPassword = "$6$qRDf73LqqlnrtGKd$fwNbmyhVjAHfgjPpM.Wn8YoYVbLRq1oFWN15fjP3b.cVW8Dv3s/7q8NY4WBYY7x1Xe71S.AHpuqL1PY6IJe0x1";
        shell = pkgs.fish;
      };
    };
  };

  programs.fish.enable = true;

  boot = {
    kernelParams = [
      "quiet"

      # Enable Intel GuC/HuC
      "i915.enable_guc=3"

      # https://wiki.cachyos.org/configuration/general_system_tweaks/#enable-rcu-lazy
      "rcutree.enable_rcu_lazy=1"
    ];
    blacklistedKernelModules = [
      # Wi-Fi
      "iwlwifi"

      # Bluetooth
      "btusb"

      # Suggested by Lynis.
      "dccp"
      "sctp"
      "rds"
      "tipc"

      # Obscure network protocols.
      "ax25"
      "netrom"
      "rose"

      # Old, rare or insufficiently audited filesystems.
      "adfs"
      "affs"
      "bfs"
      "befs"
      "cramfs"
      "efs"
      "erofs"
      "exofs"
      "freevxfs"
      "f2fs"
      "hfs"
      "hpfs"
      "jfs"
      "minix"
      "nilfs2"
      "ntfs"
      "omfs"
      "qnx4"
      "qnx6"
      "sysv"
      "ufs"
    ];
    initrd.verbose = false;
    consoleLogLevel = 0;
    # Support for my external HDD.
    supportedFilesystems = ["exfat"];
    kernelPackages = pkgs.linuxPackages_cachyos-server;
  };

  # Mount the external HDD with noexec
  fileSystems."/mnt/external" = {
    device = "/dev/sda1";
    fsType = "exfat";
    options = ["umask=0000" "nofail" "noexec"];
    noCheck = true; # This disables fsck.
  };

  # Bind mount with noexec explicitly set
  fileSystems."/home/alex/media" = {
    device = "/mnt/external/media";
    options = ["bind" "noexec"];
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

  programs.nix-ld.enable = true;

  environment.systemPackages = [
    pkgs.git
  ];

  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = true;
    settings.PermitRootLogin = "yes";
  };

  modules = {
    core.enable = true;
    dbus.enable = true;
    nh.enable = true;
    sudo-rs.enable = true;
    systemd-boot.enable = true;
    zram.enable = true;
    docker.enable = true;
    samba.enable = false;
    netbird.enable = true;

    # Security
    firewall.enable = true;
    chrony.enable = true;
  };

  services.clamav = {
    daemon.enable = true;
    updater.enable = true;
    updater.frequency = 24;
    updater.interval = "hourly";
  };

  # Did you read the comment?
  system.stateVersion = "25.05";
}
