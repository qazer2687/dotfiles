{
  lib,
  config,
  pkgs,
  ...
}: {
  options.modules.alacritty.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.alacritty.enable {
    home.packages = with pkgs; [
      alacritty
    ];
    xdg.configFile."alacritty/alacritty.toml".text = builtins.readFile ./config/default;
  };
}
