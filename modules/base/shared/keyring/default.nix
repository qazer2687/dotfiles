{
  lib,
  config,
  pkgs,
  inputs,
  ...
}: {
  options.modules.keyring.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.keyring.enable {
    services.gnome.gnome-keyring.enable = true;
    security.pam.services.login.enableGnomeKeyring = true;
  };
}
