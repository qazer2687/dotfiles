{
  lib,
  config,
  pkgs,
  ...
}: {
  options.homeModules.polybar.enable = lib.mkEnableOption "";

  config = lib.mkIf config.homeModules.polybar.enable {
    # Installation
    home.packages = with pkgs; [polybarFull];

    # Configuration
    xdg.configFile."polybar/launch.sh".text = builtins.readFile ./scripts/launch.sh;
    xdg.configFile."polybar/launch.sh".executable = true;
    xdg.configFile."polybar/config.ini".text = builtins.readFile ./config/jade;
  };
}
