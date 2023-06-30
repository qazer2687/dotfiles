{ inputs, lib, config, pkgs, ... }:
{
  options.modules.misc.mouseaccel.enable = lib.mkEnableOption "";
  config = lib.mkIf config.modules.misc.mouseaccel.enable {
    services.xserver = {
      libinput = {
        enable = true;
        mouse.accelProfile = "flat"; 
        mouse.accelSpeed = "0";
      };
    };
  };
}