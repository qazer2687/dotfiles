{
  lib,
  config,
  pkgs,
  ...
}: {
  options.homeModules.alacritty.enable = lib.mkEnableOption "";

  config = lib.mkIf config.homeModules.alacritty.enable {
    home.packages = with pkgs; [
      alacritty
    ];
    xdg.configFile."alacritty/alacritty.yaml".text = builtins.readFile ./config/default;
  };
}
