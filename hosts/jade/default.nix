{
  pkgs,
  lib,
  ...
}: {
  imports = [
    ../../hardware/jade
    ../../modules/nixos
  ];

  # require for everything to not shit itself when i rebuild
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  # required for i3 to start properly
  services.xserver = {
    enable = true;
    displayManager.startx.enable = true;
  };

  # Hostname
  networking.hostName = "jade";

  # Autologin
  environment.loginShellInit = ''
    [[ "$(tty)" == /dev/tty1 ]] && startx
  '';
  services.getty.autologinUser = "alex";

  # Custom Kernel
  boot.kernelPackages = lib.mkForce pkgs.linuxPackages_xanmod ;

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

    # Utilities
    nh.enable = true;
  };

  # Did you read the comment?
  system.stateVersion = "23.05";
}
