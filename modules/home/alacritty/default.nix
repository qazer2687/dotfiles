{
  lib,
  config,
  pkgs,
  ...
}: {
  options.modules.alacritty.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.alacritty.enable {
    # alacritty is installed via homebrew
    xdg.configFile."alacritty/alacritty.toml".text = builtins.readFile ./config/default;
  };
}
