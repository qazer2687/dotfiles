{
  lib,
  config,
  ...
}: {
  options.homeModules.i3.jade.enable = lib.mkEnableOption "";
  options.homeModules.i3.ruby.enable = lib.mkEnableOption "";

  config = lib.mkMerge [
    (lib.mkIf config.homeModules.i3.jade.enable {
      # Configuration
      xdg.configFile."i3/config".text = builtins.readFile ./config/jade;
    })

    (lib.mkIf config.homeModules.i3.ruby.enable {
      # Configuration
      xdg.configFile."i3/config".text = builtins.readFile ./config/ruby;
    })
  ];
}