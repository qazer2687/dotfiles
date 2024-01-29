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
      theme = {
        name = "Fluent-dark";
        package = pkgs.fluent-gtk-theme;
      };
    };
  };
}
