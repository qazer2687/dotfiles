{
  lib,
  pkgs,
  ...
}: {
  imports = [
    ../../hardware/ruby
    ../../modules/nixos
  ];

  networking.hostName = "ruby";
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  environment.loginShellInit = ''
    [[ "$(tty)" == /dev/tty1 ]] && sway
  '';

  users.users.alex = {
    isNormalUser = true;
    extraGroups = ["networkmanager" "wheel" "video"];
  };
  
  modules = {
    kernel.enable = true;
    networkmanager.enable = true;
    pipewire.enable = true;
    systemd-boot.enable = true;
    zram.enable = true;
    tlp.enable = true;
  };
}
