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

boot = {
    kernelParams = [
      "kernel.nmi_watchdog=0"
      "fbcon=nodefer"
      "bgrt_disable"
      "quiet"
      "rd.systemd.show_status=false"
      "rd.udev.log_level=0"
      "udev.log_priority=3"
      "vt.global_cursor_default=0"
      "mitigations=off"
    ];
    initrd.verbose = false;
    consoleLogLevel = 0;
    kernelPackages = pkgs.linuxPackages_cachyos;
  };

  networking.firewall.allowedTCPPorts = [
    22 # SSH
    53 # Pihole DNS
    3000 # Grafana
    3001 # Pihole
    8000 # Portainer
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
