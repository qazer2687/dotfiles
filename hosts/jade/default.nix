{pkgs, ...}: {
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

  environment.systemPackages = with pkgs; [
    mesa
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
  };

  # State Version
  system.stateVersion = "23.05";
}
