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

  networking.firewall.allowedTCPPorts = [
    22 # SSH
   # 3000 # Gitea
   # 8096 # Jellyfin
    9090 # Cockpit
   # 25565 # Minecraft
  ];

  services.cockpit = {
    enable = true;
  };

  services.undervolt = {
    enable = true;
    turbo = 1; # disable turbo boost
    verbose = true;
    coreOffset = -50;
  };

  services.openssh = {
    enable = true;
  };

  services.xserver.displayManager.gdm.autoSuspend = false;

  modules = {
    kernel.enable = true;
    systemd-boot.enable = true;
    pipewire.enable = true;
    networkmanager.enable = true;

    containers = {
      homepage.enable = true;
    };
  };

  system.stateVersion = "23.05";
}
