{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  options.homeModules.programs.dunst.desktopConfig.enable = lib.mkEnableOption "";
  options.homeModules.programs.dunst.laptopConfig.enable = lib.mkEnableOption "";

  config = lib.mkMerge [
    (lib.mkIf config.homeModules.programs.dunst.desktopConfig.enable {
      # Installation
      home.packages = with pkgs; [dunst];

      # Configuration
      xdg.configFile."dunst/dunstrc".text = builtins.readFile ./dunstrc_desktop;
    })

    (lib.mkIf config.homeModules.programs.dunst.laptopConfig.enable {
      # Installation
      home.packages = with pkgs; [dunst];

      # Configuration
      xdg.configFile."dunst/dunstrc".text = builtins.readFile ./dunstrc_laptop;
    })
  ];
}
