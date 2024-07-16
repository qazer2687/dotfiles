{
  lib,
  config,
  pkgs,
  ...
}: {
  options.modules.filesystem.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.filesystem.enable {
    # Automount External Drives
    services.devmon.enable = true;
    services.gvfs.enable = true;
    services.udisks2.enable = true;

    # iOS Support
    services.usbmuxd.enable = true;
    environment.systemPackages = with pkgs; [
      ifuse
      libimobiledevice
    ];

    # Additional Supported Filesystems
    boot = {
      supportedFilesystems = ["ntfs" "apfs"];
    };
  };
}
