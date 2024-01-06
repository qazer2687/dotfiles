{
  lib,
  config,
  ...
}: {
  options.systemModules.udev.via.enable = lib.mkEnableOption "";

  # Allows VIA to discover compatible keyboards
  config = lib.mkIf config.systemModules.udev.via.enable {
    services.udev.extraRules = ''
      KERNEL=="hidraw*", SUBSYSTEM=="hidraw", MODE="0660", GROUP="users", TAG+="uaccess", TAG+="udev-acl"
    '';
  };
}
