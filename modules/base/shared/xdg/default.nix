{
  lib,
  config,
  pkgs,
  inputs,
  ...
}: {
  options.modules.xdg.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.xdg.enable {
    xdg.portal = {
      enable = true;
      extraPortals = [
        pkgs.xdg-desktop-portal-hyprland
        pkgs.xdg-desktop-portal-wlr
        pkgs.xdg-desktop-portal-gtk
      ];
      xdgOpenUsePortal = true;
      config = {
        common = {
          default = ["hyprland" "wlr" "gtk"];
        };
      };
    };
  };
}
