{
  lib,
  config,
  ...
}: {
  options.homeModules.gammastep.enable = lib.mkEnableOption "";

  config = lib.mkIf config.homeModules.gammastep.enable {
    services.gammastep = {
      enable = true;
      provider = "manual";
      dawnTime = "6:00-7:45";
      duskTime = "18:35-20:15";
      latitude = 51.5072;
      longitude = 0.1276;
      temperature.day = 4000;
      temperature.night = 4000;
    };
  };
}