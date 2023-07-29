{
  lib,
  config,
  ...
}: {
  options.systemModules.security.gnome-keyring.enable = lib.mkEnableOption "";

  config = lib.mkIf config.systemModules.security.gnome-keyring.enable {
    services.gnome.gnome-keyring.enable = true;
  };
}
