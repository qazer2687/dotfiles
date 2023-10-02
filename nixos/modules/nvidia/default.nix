{
  lib,
  config,
  ...
}: {
  options.systemModules.nvidia.enable = lib.mkEnableOption "";
  config = lib.mkIf config.systemModules.nvidia.enable {
    services.xserver.videoDrivers = ["nvidia"];
    hardware.nvidia = {
      modesetting.enable = true;
      open = true;
      nvidiaSettings = true;
      #package = config.boot.kernelPackages.nvidiaPackages.stable;
    };
    hardware.opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };
  };
}
