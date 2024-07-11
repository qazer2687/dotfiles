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

  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
  };

  networking = {
    networkmanager.enable = true;
    firewall = {
      enable = true;
      allowedTCPPorts = [
        22 # SSH
        3000 # Gitea
        8096 # Jellyfin
        9090 # Cockpit
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
    pipewire.enable = true;

    containers = {
      homepage.enable = true;
    };
  };

  system.stateVersion = "23.05";
}
