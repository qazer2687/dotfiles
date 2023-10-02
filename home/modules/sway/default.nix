{
  lib,
  config,
  ...
}: {
  options.homeModules.sway.ruby.enable = lib.mkEnableOption "";

  config = lib.mkIf config.homeModules.sway.ruby.enable {
    xdg.configFile."sway/config".text = builtins.readFile ./config/ruby;
  };
}

{
  lib,
  config,
  ...
}: {
  options.homeModules.sway.jade.enable = lib.mkEnableOption "";
  options.homeModules.sway.ruby.enable = lib.mkEnableOption "";

  config = lib.mkMerge [
    (lib.mkIf config.homeModules.sway.jade.enable {
      xdg.configFile."sway/config".text = builtins.readFile ./config/jade;
    })

    (lib.mkIf config.homeModules.sway.ruby.enable {
      # Configuration
      xdg.configFile."sway/config".text = builtins.readFile ./config/ruby;
    })
  ];
}