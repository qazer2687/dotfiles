{config, pkgs, ...}:
{
  home-manager.users.alex.xdg.configFile."i3/config".text = builtins.readFile ./config;
}
