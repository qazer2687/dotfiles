{config, pkgs, ...}:
{
  home-manager.users.alex.xdg.configFile."polybar/launch.sh".executable = true;
  home-manager.users.alex.xdg.configFile."polybar/launch.sh".text = builtins.readFile ./launch.sh;
  home-manager.users.alex.xdg.configFile."polybar/config.ini".text = builtins.readFile ./config.ini;

  # Scripts
  home-manager.users.alex.xdg.configFile."polybar/scripts/battery-notification.sh".executable = true;
  home-manager.users.alex.xdg.configFile."polybar/scripts/temperature-notification.sh".executable = true;
  home-manager.users.alex.xdg.configFile."polybar/scripts/signal-notification.sh".executable = true;
}