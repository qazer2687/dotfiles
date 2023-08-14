{
  lib,
  config,
  pkgs,
  ...
}: {
  options.homeModules.dunst.jade.enable = lib.mkEnableOption "";
  options.homeModules.dunst.ruby.enable = lib.mkEnableOption "";

  config = lib.mkMerge [
    (lib.mkIf config.homeModules.dunst.jade.enable {
      # Installation
      home.packages = with pkgs; [dunst];

      # Configuration
      xdg.configFile."dunst/dunstrc".text = builtins.readFile ./config/desktop;
    })

    (lib.mkIf config.homeModules.dunst.ruby.enable {
      # Installation
      home.packages = with pkgs; [dunst];

      # Configuration
      xdg.configFile."dunst/dunstrc".text = builtins.readFile ./config/laptop;
    })
  ];
}
