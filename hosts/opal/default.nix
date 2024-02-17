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
        3000  # Gitea
        8096  # Jellyfin
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
      homepage.enable = true;
      mailserver.enable = true;
    };
  };
}
