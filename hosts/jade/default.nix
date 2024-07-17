{...}: {
  imports = [
    ../../hardware/jade
    ../../modules/nixos
  ];

  networking.hostName = "jade";
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  # startx
  services.xserver = {
    enable = true;
    displayManager.startx.enable = true;
  };

  environment.loginShellInit = ''
    [[ "$(tty)" == /dev/tty1 ]] && startx
  '';

  # autologin
  services.getty.autologinUser = "alex";

  # Remote Builds
  services.openssh.enable = true;
  services.openssh.settings.PermitRootLogin = "yes";
    networking.firewall.allowedTCPPorts = [
    22 # SSH
  ];
  nix = {
    settings = {
      system-features = [
        "big-parallel"
      ];
      trusted-users = [
        "root"
        "alex"
      ];
      max-jobs = 12;
      cores = 24;
    };
    buildMachines = [{
      hostName = "jade";
      protocol = "ssh-ng";
      systems = ["x86_64-linux" "aarch64-linux"];
      maxJobs = 12;
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



  # Modules
  modules = {
    kernel.enable = true;
    networkmanager.enable = true;
    nvidia.enable = true;
    pipewire.enable = true;
    systemd-boot.enable = true;
    steam.enable = true;
    filesystem.enable = true;
    fonts.enable = true;
    keymap.enable = true;
    zram.enable = true;
  };

  # State Version
  system.stateVersion = "23.05";
}
