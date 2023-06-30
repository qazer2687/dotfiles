{ inputs, lib, config, pkgs, ... }:
{
  options.modules.boot.systemd-boot.enable = lib.mkEnableOption "";
  config = lib.mkIf config.modules.boot.systemd-boot.enable {
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;
    boot.loader.efi.efiSysMountPoint = "/boot/efi";
  };
}