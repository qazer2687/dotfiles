{
  lib,
  config,
  pkgs,
  ...
}: {
  options.homeModules.webcord.jade.enable = lib.mkEnableOption "";
  options.homeModules.webcord.ruby.enable = lib.mkEnableOption "";

  config = lib.mkMerge [
    (lib.mkIf config.homeModules.webcord.jade.enable {
      # Installation
      home.packages = with pkgs; [webcord-vencord];

      # Configuration
      xdg.configFile."WebCord/Themes/jade.theme.css".text = builtins.readFile ./config/jade;
    })

    (lib.mkIf config.homeModules.webcord.ruby.enable {
      # Installation
      home.packages = with pkgs; [webcord-vencord];

      # Configuration
      xdg.configFile."WebCord/Themes/ruby.theme.css".text = builtins.readFile ./config/ruby;
    })
  ];
}
