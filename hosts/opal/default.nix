{pkgs, ...}: {
  imports = [
    ../../hardware/opal
    ../../modules/server
    ../../modules/nixos
  ];

  networking.hostName = "opal";

  users.users.alex = {
    isNormalUser = true;
    extraGroups = ["networkmanager" "wheel" "video"];
  };

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

  # Remote Builds
  services.openssh.enable = true;
  nix = {
    settings = {
      require-sigs = false;
      system-features = [
        "big-parallel"
      ];
      trusted-users = [
        "root"
        "alex"
      ];
      max-jobs = 6;
      cores = 8;
    };
    buildMachines = [{
      hostName = "jade";
      protocol = "ssh-ng";
      systems = ["x86_64-linux" "aarch64-linux"];
      maxJobs = 6;
      speedFactor = 2;
      supportedFeatures = [ "nixos-test" "benchmark" "big-parallel" "kvm" ];
      mandatoryFeatures = [ ];
	  }];
    distributedBuilds = true;
    extraOptions = ''
	    builders-use-substitutes = true
	  '';
  };
  boot.binfmt.emulatedSystems = [
    "aarch64-linux"
  ];

  services.cockpit = {
    enable = true;
    port = 10000;
  };

  /*services.undervolt = {
    enable = true;
    turbo = 1; # disable turbo boost
    verbose = true;
    coreOffset = -150;
  }; */ # lots of silly bomboclat issues caused by this option

  services.xserver.displayManager.gdm.autoSuspend = false;

  modules = {
    kernel.enable = true;
    systemd-boot.enable = true;
    pipewire.enable = true;
    networkmanager.enable = true;
    fonts.enable = true;
    keymap.enable = true;
    zram.enable = true;

    # Server Modules
    docker.enable = true;
  };

  system.stateVersion = "23.05";
}
