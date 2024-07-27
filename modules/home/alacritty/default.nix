{
  lib,
  config,
  ...
}: {
  options.modules.alacritty.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.alacritty.enable {
    programs.alacritty.enable = true;
    xdg.configFile."alacritty/alacritty.toml".text = builtins.readFile ./config/default;
  };
}
