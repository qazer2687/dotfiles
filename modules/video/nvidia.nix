{ inputs, lib, config, pkgs, ... }:
{
  options.modules.video.nvidia.enable = lib.mkEnableOption "";
  config = lib.mkIf config.modules.video.nvidia.enable {
    hardware.nvidia.package = [ "config.boot.kernelPackages.nvidiaPackages.stable" ];
    boot.kernelModules = [ "nvidia" ];
  };
}
