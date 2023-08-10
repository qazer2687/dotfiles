{
  lib,
  config,
  pkgs,
  ...
}: {
  options.homeModules.programs.discord.desktopConfig.enable = lib.mkEnableOption "";
  options.homeModules.programs.discord.laptopConfig.enable = lib.mkEnableOption "";

  config = lib.mkMerge [
    (lib.mkIf config.homeModules.programs.discord.desktopConfig.enable {
    # Installation
    home.packages = with pkgs; [webcord-vencord];

    # Configuration
    xdg.configFile."WebCord/Themes/catpuccin-mocha-rosewater.theme.css".text = builtins.readFile ./config/desktop;
    })

    (lib.mkIf config.homeModules.programs.discord.laptopConfig.enable {
    # Installation
    home.packages = with pkgs; [webcord-vencord];

    # Configuration
    xdg.configFile."WebCord/Themes/catpuccin-macchiato.theme.css".text = builtins.readFile ./config/laptop;
    })
  ];
}