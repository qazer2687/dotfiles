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
  fileSystems."/home/alex/media" = {
    device = "/mnt/external/media";
    options = ["bind"];
  };
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
  
  environment.etc."motd-logo".text = ''
\033[38;2;230;0;0m
Welcome to Mica!
\033[0m
  '';

  programs.fish.loginShellInit = ''
    printf '%b' "$(cat /etc/motd-logo)"
  '';


  # Support for vscode remote server.
  programs.nix-ld.enable = true;

  environment.systemPackages = [
    pkgs.git
  ];

  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = true;
    settings.PermitRootLogin = "yes";
  };

  networking.firewall.allowedTCPPorts = [
    6443 # k3s: required so that pods can reach the API server (running on port 6443 by default)
    2379 # k3s, etcd clients: required if using a "High Availability Embedded etcd" configuration
    2380 # k3s, etcd peers: required if using a "High Availability Embedded etcd" configuration
  ];
  networking.firewall.allowedUDPPorts = [
    8472 # k3s, flannel: required if using multi-node for inter-node networking
  ];
  
  sops.secrets.k3s = {
    sopsFile = ../../secrets/k3s.yaml;
    key      = "token";
    mode     = "0400";
    owner    = "root";
    group    = "root";
  };
  services.k3s = {
    enable      = true;
    role        = "server";
    clusterInit = true;
    tokenFile   = config.sops.secrets.k3s.path;
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
    tailscale.enable = true;

    # Security
    firewall.enable = true;
    chrony.enable = true;

  };

  # Did you read the comment?
  system.stateVersion = "25.05";
}
