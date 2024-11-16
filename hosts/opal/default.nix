{
  config,
  pkgs,
  ...
}: {
  imports = [
    ../../hardware/opal
    ../../modules/server
    ../../modules/nixos
  ];

  users.users.alex = {
    isNormalUser = true;
    extraGroups = ["networkmanager" "wheel" "video"];
  };

  # Hostname
  networking.hostName = "opal";

  networking.firewall.allowedTCPPorts = [
    22 # SSH
    53 # Pihole DNS
    3000 # Grafana
    3001 # Pihole
    9090 # Prometheus
    9100 # Node Exporter (Prometheus)
    10000 # Cockpit
    # 25565 # Minecraft
  ];

  services.cockpit = {
    enable = true;
    port = 10000;
  };

  services.xserver.displayManager.gdm.autoSuspend = false;

  modules = {
    core.enable = true;
    systemd-boot.enable = true;
    pipewire.enable = true;
    networkmanager.enable = true;
    zram.enable = true;
    tailscale.enable = true;

    # Server Modules
    server = {
      docker.enable = true;
      caddy.enable = true;
    };
  };

  system.stateVersion = "23.05";
}
