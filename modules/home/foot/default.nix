{
  lib,
  config,
  ...
}: {
  options.modules.foot.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.foot.enable {
    programs.foot = {
      enable = true;
    };
    xdg.configFile."foot/foot.ini".text = builtins.readFile ./config/default;
  };
}
