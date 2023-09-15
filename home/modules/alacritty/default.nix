{
  lib,
  config,
  pkgs,
  ...
}: {
  options.homeModules.alacritty.enable = lib.mkEnableOption "";
  options.homeModules.alacritty.catppuccin.enable = lib.mkEnableOption "";

  config = lib.mkMerge [
    (lib.mkIf config.homeModules.alacritty.enable {
      home.packages = with pkgs; [alacritty];
    })

    (lib.mkIf config.homeModules.alacritty.catppuccin.enable {
      xdg.configFile."alacritty/alacritty.yml".text = builtins.readFile ./config/catppuccin;
    })
  ];
}
