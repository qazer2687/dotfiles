{
  lib,
  config,
  pkgs,
  ...
}: {
  options.homeModules.dunst.enable = lib.mkEnableOption "";

  config = lib.mkIf config.homeModules.dunst.jade.enable {
    home.packages = with pkgs; [dunst];
    xdg.configFile."dunst/dunstrc".text = builtins.readFile ./config/default;
  };
}
