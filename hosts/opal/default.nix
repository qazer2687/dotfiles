{pkgs, ...}: {
  imports = [
    ../../hardware/opal
    ../../containers
    ../../modules/nixos
  ];

  networking.hostName = "opal";

  users.users.alex = {
    isNormalUser = true;
    extraGroups = ["networkmanager" "wheel" "video"];
  };

  networking = {
    networkmanager.enable = true;
    firewall = {
      enable = true;
      allowedTCPPorts = [
        22    # SSH
        25    # SMTP
        80    # HTTP (Homepage Dashboard)
        110   # POP3
        143   # IMAP
        443   # HTTPS
        465   # SMTPS
        587   # TLS
        993   # IMAPS
        995   # POP3S
        3000  # HTTP (Gitea)
        4190  # ManageSieve
        8080  # HTTP
        8096  # HTTP (Jellyfin)
        9090  # Cockpit
        25565 # Minecraft
      ];
    };
  };
  systemd = {
    services.NetworkManager-wait-online.enable = false;
    network.wait-online.enable = false;
  };

  services.cockpit = {
    enable = true;
  };

  services.jellyfin = {
    enable = true;
    user = "alex";
  };

  environment.systemPackages = with pkgs; [
    qbittorrent-nox
    flood
  ];

  modules = {
    kernel.enable = true;
    systemd-boot.enable = true;
    zram.enable = true;

    containers = {
      homepage.enable = false;
      mailserver.enable = true;
    };
  };
}
