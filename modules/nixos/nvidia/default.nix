{
  lib,
  config,
  ...
}: {
  options.modules.nvidia.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.nvidia.enable {
    services.xserver.videoDrivers = ["nvidia"];
    hardware.nvidia = {
      # Modesetting is required.
      modesetting.enable = true;

      # Use the nvidia open source kernel module.
      open = true;

      # Enable the nvidia settings menu.
      nvidiaSettings = true;

      package = config.boot.kernelPackages.nvidiaPackages.stable;
    };
  };
}
