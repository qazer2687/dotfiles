{
  lib,
  config,
  pkgs,
  ...
}: {
  options.modules.dunst.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.dunst.enable {
    home.packages = with pkgs; [dunst];
    xdg.configFile."dunst/dunstrc".text = builtins.readFile ./config/default;
  };
}
