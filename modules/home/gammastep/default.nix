{
  lib,
  config,
  ...
}: {
  options.modules.gammastep.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.gammastep.enable {
    services.gammastep = {
      enable = true;
      provider = "manual";
      latitude = 51.5;
      longitude = 0.1;
      temperature.day = 2000;
      temperature.night = 2000;
    };
  };
}
