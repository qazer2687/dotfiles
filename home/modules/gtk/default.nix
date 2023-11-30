{
  lib,
  config,
  pkgs,
  ...
}: {
  options.homeModules.gtk.enable = lib.mkEnableOption "";

  config = lib.mkIf config.homeModules.gtk.enable {
    gtk = {
      enable = true;
      font.name = "FiraMono Nerd Font Medium 12";
      theme = {
        name = "WhiteSur-Dark";
        package = pkgs.whitesur-gtk-theme;
      };
    };
  };
}
