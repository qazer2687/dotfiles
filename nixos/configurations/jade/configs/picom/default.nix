{
  config,
  pkgs,
  ...
}: {
  home-manager.users.alex.xdg.configFile."picom/picom.conf".text = builtins.readFile ./picom.conf;
}
