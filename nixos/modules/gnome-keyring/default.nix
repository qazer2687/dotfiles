{
  lib,
  config,
  ...
}: {
  options.systemModules.gnome-keyring.enable = lib.mkEnableOption "";

  config = lib.mkIf config.systemModules.gnome-keyring.enable {
    services.gnome.gnome-keyring.enable = true;
    security.pam.services.gdm.enableGnomeKeyring = true;
    programs.seahorse.enable = true;
  };
}
