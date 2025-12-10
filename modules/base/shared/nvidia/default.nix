{
  lib,
  config,
  ...
}: {
  options.modules.nvidia.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.nvidia.enable {
    hardware.graphics.enable = true;
    hardware.nvidia = {
      # Enable the open source kernel module (NOT nouveau drivers).
      open = false;
      package = config.boot.kernelPackages.nvidiaPackages.stable;
    };
    services.xserver = {
      videoDrivers = ["nvidia"];
    };
  };
}