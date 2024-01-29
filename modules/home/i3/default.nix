{
  lib,
  config,
  ...
}: {
  options.modules.i3.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.i3.enable {
    xdg.configFile."i3/config".text = builtins.readFile ./config/default;
  };
}
