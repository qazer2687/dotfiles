{
  lib,
  config,
  ...
}: {
  options.systemModules.security.gnome-keyring.enable = lib.mkEnableOption "";

  config = lib.mkIf config.systemModules.security.gnome-keyring.enable {
    # Configuration
    services.gnome.gnome-keyring.enable = true;
  };
}
