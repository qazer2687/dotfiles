{
  lib,
  config,
  pkgs,
  ...
}: {
  options.modules.filesystem.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.filesystem.enable {
    services.devmon.enable = true;
    services.gvfs.enable = true;
    services.udisks2.enable = true;

    #? For iOS support.
    services.usbmuxd.enable = true;
    environment.systemPackages = with pkgs; [
      ifuse
      libimobiledevice
    ];

    boot = {
      supportedFilesystems = ["ntfs"];
    };
  };
}
