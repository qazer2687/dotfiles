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

      # Misc
      "dccp"
      "sctp"
      "rds"
      "tipc"
    ];
    initrd.verbose = false;
    consoleLogLevel = 0;
    # Support for my external HDD.
    supportedFilesystems = ["exfat"];
    kernelPackages = pkgs.linuxPackages_cachyos-server;
  };

  # Mount the external HDD.
  fileSystems."/mnt/external" = {
    device = "/dev/sda1";
    fsType = "exfat";
    options = ["umask=0000" "nofail"];
    noCheck = true; # This disables fsck.
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

  programs.nix-ld.enable = true;

  users.motd = "Unauthorized access prohibited. All activity monitored.";
  environment.etc."issue".text = "Unauthorized access prohibited. All activity monitored.\n";

  modules = {
    core.enable = true;
    zram.enable = true;
    docker.enable = true;

    # Security
    firewall.enable = true;
    chrony.enable = true;
    sysctl.enable = true;
    logrotate.enable = true;
    pam.enable = true;
    lynis.enable = true;
  };

  # Did you read the comment?
  system.stateVersion = "25.05";

  # Lynis Misc

  environment.systemPackages = with pkgs; [
    # [PKGS-7398] Install a package audit tool
    vulnix
    # [HRDN-7230] Install a malware scanner
    chkrootkit
  ];

  # [ACCT-9626] Enable sysstat to collect accounting
  services.sysstat.enable = true;

  # [ACCT-9628] Enable auditd to collect audit information
  security.audit.enable = true;
  security.auditd.enable = true;
}
