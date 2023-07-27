{
  config,
  pkgs,
  ...
}: {
  home-manager.users.alex.xdg.configFile."dunst/dunstrc".text = builtins.readFile ./dunstrc;
}
