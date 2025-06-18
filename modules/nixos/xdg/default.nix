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
   
    # Allow XDG to access .desktop files.
    environment.pathsToLink = [ "/share/applications" ];

    xdg = {
      portal = {
        enable = true;
        wlr.enable = true;
        extraPortals = [
          pkgs.xdg-desktop-portal-gtk
        ];
        xdgOpenUsePortal = true;
        config.common.default = ["wlr" "gtk"];
      };
      mime = {
        enable = true;
        defaultApplications = {
          "text/html" = "firefox.desktop";
          "x-scheme-handler/http" = "firefox.desktop";
          "x-scheme-handler/https" = "firefox.desktop";
        };
      };
      icons = {
        enable = true;
      };
    };
  };
}
