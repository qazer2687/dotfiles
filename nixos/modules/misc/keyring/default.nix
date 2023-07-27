{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  options.systemModules.misc.keyring.enable = lib.mkEnableOption "";

  config = lib.mkIf config.systemModules.misc.keyring.enable {
    services.gnome.gnome-keyring.enable = true;
  };
}
