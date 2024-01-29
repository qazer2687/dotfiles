{
  lib,
  config,
  pkgs,
  ...
}: {
  options.homeModules.polybar.enable = lib.mkEnableOption "";

  config = lib.mkIf config.homeModules.polybar.enable {
    home.packages = with pkgs; [polybarFull];
    xdg.configFile."polybar/config.ini".text = builtins.readFile ./config/default;
  };
}
