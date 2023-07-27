{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  options.homeModules.programs.polybar.desktopConfig.enable = lib.mkEnableOption "";
  options.homeModules.programs.polybar.laptopConfig.enable = lib.mkEnableOption "";

  config = lib.mkMerge [
    (lib.mkIf config.homeModules.programs.polybar.desktopConfig.enable {
      # Installation
      home.packages = with pkgs; [polybarFull];

      # Configuration
      xdg.configFile."polybar/launch.sh".text = builtins.readFile ./launch.sh;
      xdg.configFile."polybar/launch.sh".executable = true;
      xdg.configFile."polybar/config.ini".text = builtins.readFile ./config_desktop.ini;
    })

    (lib.mkIf config.homeModules.programs.polybar.laptopConfig.enable {
      # Installation
      home.packages = with pkgs; [polybarFull];

      # Configuration
      xdg.configFile."polybar/launch.sh".text = builtins.readFile ./launch.sh;
      xdg.configFile."polybar/launch.sh".executable = true;
      xdg.configFile."polybar/config.ini".text = builtins.readFile ./config_laptop.ini;

      # Scripts
      xdg.configFile."polybar/scripts/battery-notification.sh".executable = true;
      xdg.configFile."polybar/scripts/battery-notification.sh".text = builtins.readFile ./scripts/battery-notification.sh;

      xdg.configFile."polybar/scripts/temperature-notification.sh".executable = true;
      xdg.configFile."polybar/scripts/temperature-notification.sh".text = builtins.readFile ./scripts/temperature-notification.sh;

      xdg.configFile."polybar/scripts/signal-notification.sh".executable = true;
      xdg.configFile."polybar/scripts/signal-notification.sh".text = builtins.readFile ./scripts/signal-notification.sh;
    })
  ];
}
