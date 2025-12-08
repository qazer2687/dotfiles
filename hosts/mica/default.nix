{pkgs, config, ...}: {
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
    initrd.verbose = false;
    consoleLogLevel = 0;
    # Support for my external HDD.
    supportedFilesystems = ["exfat"];
    kernelPackages = pkgs.linuxPackages_cachyos-server;
  };


  # Mount external drive.
  fileSystems."/mnt/external" = {
    device = "/dev/sda1";
    fsType = "exfat";
    options = ["umask=0000" "nofail"];
    noCheck = true; # This disables fsck.
  };

  # Bind mounts.
  fileSystems."/home/alex/data" = {
    device = "/mnt/external/data";
    options = ["bind"];
  };

  # Spin down the external HDD after 60 minutes of inactivity.
  systemd.services.hdparm = {
    description = "/dev/sda Spin Down ";
    wantedBy = ["multi-user.target"];
    after = ["local-fs.target"];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.hdparm}/bin/hdparm -S 242 /dev/sda";
    };
  };

  # Support for vscode remote server.
  programs.nix-ld.enable = true;

  environment.systemPackages = [
    pkgs.git
  ];

  modules = {
    core.enable = true;
    dbus.enable = true;
    nh.enable = true;
    sudo-rs.enable = true;
    systemd-boot.enable = true;
    zram.enable = true;
    docker.enable = true;
    samba.enable = false;
    tailscale.enable = true;

    # Security
    firewall.enable = true;
    chrony.enable = true;

  };

  # Did you read the comment?
  system.stateVersion = "25.05";
}
