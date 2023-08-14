{
  lib,
  config,
  ...
}: {
  options.systemModules.libinput.enable = lib.mkEnableOption "";

  config = lib.mkIf config.systemModules.libinput.enable {
    services.xserver = {
      libinput = {
        enable = true;
        mouse.accelProfile = "flat";
        mouse.accelSpeed = "0";
      };
    };
  };
}
