{
  lib,
  config,
  ...
}: {
  options.homeModules.foot.enable = lib.mkEnableOption "";

  config = lib.mkIf config.homeModules.foot.enable {
    programs.foot = {
      enable = true;
    };
    xdg.configFile."foot/foot.ini".text = builtins.readFile ./config/foot;
  };
}
