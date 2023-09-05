{
  lib,
  config,
  ...
}: {
  options.homeModules.foot.jade.enable = lib.mkEnableOption "";
  options.homeModules.foot.ruby.enable = lib.mkEnableOption "";

  config = lib.mkMerge [
    (lib.mkIf config.homeModules.foot.jade.enable {
      # Placeholder
    })

    (lib.mkIf config.homeModules.foot.ruby.enable {
      # Installation
      programs.foot = {
        enable = true;
      };

      # Configuration
      xdg.configFile."foot/foot.ini".text = builtins.readFile ./config/ruby;
    })
  ];
}
