{...}: {
  imports = [
    ../../hardware/opal
    ../../modules/nixos
  ];

  users.users.alex = {
    isNormalUser = true;
    extraGroups = ["networkmanager" "wheel" "video"];
  };

  boot = {
    kernelParams = [
      "quiet"
      "mitigations=off"
    ];
    blacklistedKernelModules = [
      # Disable the watchdog timer to stop
      # watchdog from hanging on poweroff.
      "iTCO_wdt"
    ];
    initrd.verbose = false;
    consoleLogLevel = 0;

    #kernelPackages = pkgs.linuxPackages_cachyos;
    #kernelPackages = pkgs.linuxPackages_xanmod;
  };

  networking.hostName = "opal";

  hardware.nvidia-container-toolkit.enable = true;

  networking.firewall = {
    enable = true;
    # The services on these ports are public,
    # everything else is routed through my tailnet.
    allowedTCPPorts = [
      22
      # Nginx Proxy Manager
      80
      81
      443
      # Conduwuit
      8448
    ];
  };

  modules = {
    core.enable = true;
    systemd-boot.enable = true;
    zram.enable = true;
    tailscale.enable = true;
    nvidia.enable = true;
    docker.enable = true;
  };

  # Did you read the comment?
  system.stateVersion = "23.05";
}
