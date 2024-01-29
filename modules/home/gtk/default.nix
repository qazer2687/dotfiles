{
  lib,
  config,
  pkgs,
  ...
}: {
  options.modules.gtk.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.gtk.enable {
    gtk = {
      enable = true;
      theme = {
        name = "Fluent-dark";
        package = pkgs.fluent-gtk-theme;
      };
    };
  };
}
