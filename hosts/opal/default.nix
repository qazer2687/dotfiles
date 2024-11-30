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

    # I didn't realise this would compile from source, my server will probably
    # explode trying to accomplish that. CachyOS' server kernel is also optimized
    # for throughput, but I don't really run anything intensive yet so I don't
    # think it matters.
    #kernelPackages = pkgs.linuxPackages_cachyos;
    kernelPackages = pkgs.linuxPackages_xanmod;
  };

  networking.firewall.allowedTCPPorts = [
    22 # SSH
    53 # Pihole DNS
    80
    443
    3000 # Grafana
    3001 # Pihole
    8000 # Portainer
    9090 # Prometheus
    9100 # Node Exporter (Prometheus)
    10000 # Cockpit
    # 25565 # Minecraft
  ];

 /* services.cockpit = {
    enable = true;
    port = 10000;
  };*/

  # I have installed gnome before so autosuspend
  # seems to be set statefully somewhere.
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
      samba.enable = true;
      nginx.enable = false;
      homepage-dashboard.enable = true;
    };
  };

  system.stateVersion = "23.05";
}
