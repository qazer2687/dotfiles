{ inputs, lib, config, pkgs, ... }:
{
  options.modules.misc.keyring.enable = lib.mkEnableOption "";
  config = lib.mkIf config.modules.misc.keyring.enable {
    services.gnome.gnome-keyring.enable = true;
  };
}