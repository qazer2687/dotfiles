{ inputs, lib, config, pkgs, ... }:
{
  options.modules.video.nvidia.enable = lib.mkEnableOption "";
  config = lib.mkIf config.modules.video.nvidia.enable {
    services.xserver = {
      videoDrivers = [ "nvidiaBeta" ];
    };
  };
}