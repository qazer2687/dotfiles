{
  lib,
  config,
  ...
}: {
  options.homeModules.gammastep.enable = lib.mkEnableOption "";

  config = lib.mkIf config.homeModules.gammastep.enable {
    services.gammastep = {
      enable = true;
      latitude = 51.5;
      longitude = 0.1;
      temperature.day = 4000;
      temperature.night = 4000;
    };
  };
}