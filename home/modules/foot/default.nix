{
  lib,
  config,
  ...
}: {
  options.homeModules.foot.enable = lib.mkEnableOption "";

  options.homeModules.foot.host = lib.mkOption {
    default = "";
    type = lib.types.str;
    description = "Choose the host-specific configuration. (e.g. 'jade' or 'ruby')";
  };

  config = lib.mkIf config.homeModules.foot.enable {
    programs.foot = {
      enable = true;
    };

    xdg.configFile."foot/foot.ini".text = builtins.readFile ./config/${config.homeModules.foot.host};
  };
}
