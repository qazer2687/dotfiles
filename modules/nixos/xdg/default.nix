{
  lib,
  config,
  pkgs,
  ...
}: {
  options.modules.xdg.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.xdg.enable {
    services.dbus = {
      enable = true;
      # EXPERIMENTAL - High performance implementation of the dbus specification.
      implementation = "broker";
    };

    environment.systemPackages = with pkgs; [
      xdg-utils
      xdg-desktop-portal-gnome
      xdg-desktop-portal-gtk
      xdg-desktop-portal-wlr
    ];

    xdg = {
      portal = {
        enable = true;
        wlr.enable = true;
        extraPortals = [
          pkgs.xdg-desktop-portal-gtk
          pkgs.xdg-desktop-portal-gnome
        ];
        xdgOpenUsePortal = true;
        # Fix 'xdg-desktop-portal 1.17 reworked how
        # portal implementations are loaded' warning.
        config.common.default = "*";
      };
      mime = {
        enable = true;
      };
      icons = {
        enable = true;
      };
    };
  };
}
