{pkgs, config, ...}: {
  imports = [
    ../../hardware/juniper
  ];

  networking.hostName = "juniper";

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

      # https://wiki.cachyos.org/configuration/general_system_tweaks/#enable-rcu-lazy
      "rcutree.enable_rcu_lazy=1"
    ];
    initrd.verbose = false;
    consoleLogLevel = 0;
    kernelPackages = pkgs.linuxPackages_cachyos-server;
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
    enable = true;
    role = "agent";
    tokenFile = config.sops.secrets.k3s.path;
    serverAddr = "https://100.111.111.111:6443";
  };

  # Support for vscode remote server.
  programs.nix-ld.enable = true;


  modules = {
    core.enable = true;
    dbus.enable = true;
    nh.enable = true;
    sudo-rs.enable = true;
    systemd-boot.enable = true;
    zram.enable = true;
    tailscale.enable = true;

    # Security
    firewall.enable = true;
    chrony.enable = true;
  };

  # Did you read the comment?
  system.stateVersion = "25.05";
}
