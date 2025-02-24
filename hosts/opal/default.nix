{...}: {
  imports = [
    ../../hardware/opal
    ../../modules/server
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

  # I have installed gnome before so autosuspend
  # seems to be set statefully somewhere.
  #services.xserver.displayManager.gdm.autoSuspend = false;

  modules = {
    core.enable = true;
    systemd-boot.enable = true;
    zram.enable = true;
    tailscale.enable = true;
    nvidia.enable = true;

    server = {
      docker.enable = true;
      #samba.enable = true;
      homepage-dashboard.enable = true;
    };
  };

  # Did you read the comment?
  system.stateVersion = "23.05";
}
