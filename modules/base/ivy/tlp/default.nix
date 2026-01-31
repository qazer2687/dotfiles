{
  lib,
  config,
  pkgs,
  ...
}: {
  options.modules.tlp.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.tlp.enable {
    services.tlp = {
      enable = true;
      settings = {
        START_CHARGE_THRESH_BAT1 = 75;
        STOP_CHARGE_THRESH_BAT1 = 80;
      };
    };
  };
}
