{
  lib,
  config,
  pkgs,
  ...
}: {
  options.homeModules.discord.jade.enable = lib.mkEnableOption "";
  options.homeModules.discord.ruby.enable = lib.mkEnableOption "";

  config = lib.mkMerge [
    (lib.mkIf config.homeModules.discord.jade.enable {
    # Installation
    home.packages = with pkgs; [webcord-vencord];

    # Configuration
    xdg.configFile."WebCord/Themes/desktop.theme.css".text = builtins.readFile ./config/desktop;
    })

    (lib.mkIf config.homeModules.discord.ruby.enable {
    # Installation
    home.packages = with pkgs; [webcord-vencord];

    # Configuration
    xdg.configFile."WebCord/Themes/laptop.theme.css".text = builtins.readFile ./config/laptop;
    })
  ];
}