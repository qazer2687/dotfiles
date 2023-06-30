{ inputs, lib, config, pkgs, ... }:
{
  options.modules.desktop.gdm.enable = lib.mkEnableOption "";
  config = lib.mkIf config.modules.desktop.gdm.enable {
    services.xserver = {
      enable = true;
      displayManager.gdm.enable = true;
    };
    boot.loader.efi.canTouchEfiVariables = true;
    boot.loader.efi.efiSysMountPoint = "/boot/efi";
  };
}