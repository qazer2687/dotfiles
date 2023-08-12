{
  lib,
  config,
  pkgs,
  ...
}: {
  options.homeModules.programs.i3.jade.enable = lib.mkEnableOption "";
  options.homeModules.programs.i3.ruby.enable = lib.mkEnableOption "";

  config = lib.mkMerge [
    (lib.mkIf config.homeModules.programs.i3.jade.enable {

      # Configuration
      xdg.configFile."i3/config".text = builtins.readFile ./config/desktop;
    })

    (lib.mkIf config.homeModules.programs.i3.ruby.enable {

      # Configuration
      xdg.configFile."i3/config".text = builtins.readFile ./config/laptop;
    })
  ];
}
