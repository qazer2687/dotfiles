{
  lib,
  config,
  ...
}: {
  options.systemModules.misc.mouseaccel.enable = lib.mkEnableOption "";

  config = lib.mkIf config.systemModules.misc.mouseaccel.enable {
    services.xserver = {
      libinput = {
        enable = true;
        mouse.accelProfile = "flat";
        mouse.accelSpeed = "0";
      };
    };
  };
}
