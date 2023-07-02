{ inputs, lib, config, pkgs, ... }:
{
  options.modules.video.nvidia.enable = lib.mkEnableOption "";
  config = lib.mkIf config.modules.video.nvidia.enable {
    boot.kernelModules = [ "nvidia" ];
    services.xserver.videoDrivers = [ "nvidia" ];
    hardware.opengl = {
      enable = true;
      driSupport32Bit = true;
    };
  };
}
