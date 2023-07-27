{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  options.systemModules.boot.loader.systemd-boot.enable = lib.mkEnableOption "";

  config = lib.mkIf config.systemModules.boot.loader.systemd-boot.enable {
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;
    boot.loader.efi.efiSysMountPoint = "/boot/efi";
    boot.loader.timeout = 0;
  };
}
