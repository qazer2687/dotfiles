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
      latitude = 51.5072;
      longitude = 0.1276;
      temperature.day = 4000;
      temperature.night = 4000;
    };
  };
}