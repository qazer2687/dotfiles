{
  lib,
  config,
  pkgs,
  ...
}: {
  options.homeModules.programs.dunst.jade.enable = lib.mkEnableOption "";
  options.homeModules.programs.dunst.ruby.enable = lib.mkEnableOption "";

  config = lib.mkMerge [
    (lib.mkIf config.homeModules.programs.dunst.jade.enable {
      # Installation
      home.packages = with pkgs; [dunst];

      # Configuration
      xdg.configFile."dunst/dunstrc".text = builtins.readFile ./config/desktop;
    })

    (lib.mkIf config.homeModules.programs.dunst.ruby.enable {
      # Installation
      home.packages = with pkgs; [dunst];

      # Configuration
      xdg.configFile."dunst/dunstrc".text = builtins.readFile ./config/laptop;
    })
  ];
}
