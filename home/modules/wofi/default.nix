{
  lib,
  config,
  pkgs,
  ...
}: {
  options.homeModules.wofi.jade.enable = lib.mkEnableOption "";
  options.homeModules.wofi.ruby.enable = lib.mkEnableOption "";

  config = lib.mkMerge [
    (lib.mkIf config.homeModules.wofi.jade.enable {
    # Installation
    home.packages = with pkgs; [wofi];
    })
    (lib.mkIf config.homeModules.wofi.ruby.enable {
    # Installation
    home.packages = with pkgs; [wofi];

    # Configuration
    xdg.configFile."wofi/style.css".text = builtins.readFile ./config/laptop;
    })
  ];
}