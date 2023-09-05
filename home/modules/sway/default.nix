{
  lib,
  config,
  ...
}: {
  options.homeModules.sway.ruby.enable = lib.mkEnableOption "";

  config = lib.mkIf config.homeModules.sway.ruby.enable {
    xdg.configFile."sway/config".text = builtins.readFile ./config/laptop;
  };
}
