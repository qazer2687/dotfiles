{
  lib,
  config,
  pkgs,
  ...
}: {
  options.homeModules.programs.discord.enable = lib.mkEnableOption "";

  config = lib.mkIf config.homeModules.programs.discord.enable {
    # Installation
    home.packages = with pkgs; [webcord-vencord];

    # Configuration
    xdg.configFile."WebCord/Themes/catpuccin-mocha-rosewater.theme.css".text = builtins.readFile ./config/desktop;
  };
}
