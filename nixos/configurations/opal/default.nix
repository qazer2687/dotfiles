{
  lib,
  pkgs,
  ...
}: {
  imports = [
    ../../../hardware/opal
    ../../../containers
    ../../modules
    
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
        allowedTCPPorts = [22 80 3000 8080 8096 9090 443 25565];
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

  container.homepage-dashboard.enable = true;

  modules = {
    bash.enable = true;
    kernel.enable = true;
    systemd-boot.enable = true;
    zram.enable = true;
  };
}
