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
        name = "Adwaita-dark";
        package = pkgs.libadwaita;
      };
    };
  };
}
