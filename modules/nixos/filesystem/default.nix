{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.modules.filesystem;
in {
  options.modules.filesystem = {
    enable = lib.mkEnableOption "";
    apfsSupport = lib.mkEnableOption "";
  };

  config = lib.mkIf cfg.enable {
    services.devmon.enable = true;
    services.gvfs.enable = true;
    services.udisks2.enable = true;

    services.usbmuxd.enable = cfg.apfsSupport;
    environment.systemPackages = with pkgs; lib.optionals cfg.apfsSupport [
      ifuse
      libimobiledevice
    ];
  };
}
