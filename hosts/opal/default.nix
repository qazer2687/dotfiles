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

  

  networking.hostName = "opal";

  # I have installed gnome before so autosuspend
  # seems to be set statefully somewhere.
  #services.xserver.displayManager.gdm.autoSuspend = false;

  modules = {
    core.enable = true;
    systemd-boot.enable = true;
    zram.enable = true;
    tailscale.enable = true;

    server = {
      docker.enable = true;
      #samba.enable = true;
      homepage-dashboard.enable = true;
    };
  };

  # Did you read the comment?
  system.stateVersion = "23.05";
}
