{
  lib,
  config,
  pkgs,
  ...
}: {
  options.homeModules.programs.alacritty.jade.enable = lib.mkEnableOption "";
  options.homeModules.programs.alacritty.ruby.enable = lib.mkEnableOption "";

  config = lib.mkMerge [
    (lib.mkIf config.homeModules.programs.alacritty.jade.enable {
      # Installation
      home.packages = with pkgs; [alacritty];

      # Configuration
      xdg.configFile."alacritty/alacritty.yml".text = builtins.readFile ./config/desktop;
    })

    (lib.mkIf config.homeModules.programs.alacritty.ruby.enable {
      # Installation
      home.packages = with pkgs; [alacritty];

      # Configuration
      xdg.configFile."alacritty/alacritty.yml".text = builtins.readFile ./config/laptop;
    })
  ];
}
