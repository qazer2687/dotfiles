{
  lib,
  config,
  pkgs,
  ...
}: {
  options.homeModules.programs.discord.jade.enable = lib.mkEnableOption "";
  options.homeModules.programs.discord.ruby.enable = lib.mkEnableOption "";

  config = lib.mkMerge [
    (lib.mkIf config.homeModules.programs.discord.jade.enable {
    # Installation
    home.packages = with pkgs; [webcord-vencord];

    # Configuration
    xdg.configFile."WebCord/Themes/desktop.theme.css".text = builtins.readFile ./config/desktop;
    })

    (lib.mkIf config.homeModules.programs.discord.ruby.enable {
    # Installation
    home.packages = with pkgs; [webcord-vencord];

    # Configuration
    xdg.configFile."WebCord/Themes/laptop.theme.css".text = builtins.readFile ./config/laptop;
    })
  ];
}