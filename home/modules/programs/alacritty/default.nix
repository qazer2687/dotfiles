{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  options.homeModules.programs.alacritty.desktopConfig.enable = lib.mkEnableOption "";
  options.homeModules.programs.alacritty.laptopConfig.enable = lib.mkEnableOption "";

  config = lib.mkMerge [
    (lib.mkIf config.homeModules.programs.alacritty.desktopConfig.enable {
      # Installation
      home.packages = with pkgs; [alacritty];

      # Configuration
      xdg.configFile."alacritty/alacritty.yml".text = builtins.readFile ./alacritty_desktop.yml;
    })

    (lib.mkIf config.homeModules.programs.alacritty.laptopConfig.enable {
      # Installation
      home.packages = with pkgs; [alacritty];

      # Configuration
      xdg.configFile."alacritty/alacritty.yml".text = builtins.readFile ./alacritty_laptop.yml;
    })
  ];
}
