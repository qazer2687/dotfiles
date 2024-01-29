{
  lib,
  pkgs,
  ...
}: {
  imports = [
    ../../hardware/jade
    ../../modules/nixos
  ];

  networking.hostName = "jade";
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  environment.loginShellInit = ''
    [[ "$(tty)" == /dev/tty1 ]] && sx
  '';

  services.xserver.displayManager.sx.enable = true;

  users.users.alex = {
    isNormalUser = true;
    extraGroups = ["networkmanager" "wheel" "video"];
  };
  
  modules = {
    kernel.enable = true;
    networkmanager.enable = true;
    nvidia.enable = true;
    pipewire.enable = true;
    systemd-boot.enable = true;
    zram.enable = true;
  };
}
