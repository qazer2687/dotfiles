{config, pkgs, ...}:
{
  home-manager.users.alex.xdg.configFile."alacritty/alacritty.yml".text = builtins.readFile ./alacritty.yml;
}
