{
  lib,
  config,
  pkgs,
  ...
}: {
  options.modules.xdg.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.xdg.enable {

    environment.systemPackages = with pkgs; [
	    xdg-utils
    ];

    xdg.mime.enable = true;

    services.dbus = {
      enable = true;
      # EXPERIMENTAL - High performance implementation of the dbus specification.
      implementation = "broker";
    };
    services.xdg.portal = {
      enable = true;
      wlr.enable = true;
      extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
      xdgOpenUsePortal = true;
      # Fix 'xdg-desktop-portal 1.17 reworked how
      # portal implementations are loaded' warning.
      config.common.default = "*";
    };
  };
}
