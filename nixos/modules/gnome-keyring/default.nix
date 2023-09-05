{
  lib,
  config,
  ...
}: {
  options.systemModules.gnome-keyring.enable = lib.mkEnableOption "";

  config = lib.mkIf config.systemModules.gnome-keyring.enable {
    # Configuration
    services.gnome.gnome-keyring.enable = true;
    security.pam.services.gdm.enableGnomeKeyring = true;

    # GUI
    programs.seahorse.enable = true;
  };
}
