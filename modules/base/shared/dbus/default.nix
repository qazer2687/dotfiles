{
  lib,
  config,
  pkgs,
  inputs,
  ...
}: {
  options.modules.dbus.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.dbus.enable {
    services.dbus = {
      enable = true;
      implementation = "broker";
    };
  };
}
