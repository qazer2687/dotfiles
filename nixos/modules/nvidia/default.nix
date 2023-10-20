{
  lib,
  config,
  ...
}: {

  options.systemModules.nvidia.enable = lib.mkEnableOption "";

  options.systemModules.nvidia.driver = lib.mkOption {
    default = "stable";
    type = lib.types.str;
    description = "Choose the driver version. ('stable', 'beta' or 'production')";
  };
  
  config = lib.mkIf config.systemModules.nvidia.enable {
    services.xserver.videoDrivers = ["nvidia"];
    hardware.nvidia = {

      # Wayland Compatibility
      modesetting.enable = true;
      open = true;

      # Disable Settings Application
      nvidiaSettings = false;

      # Disable Power Management
      powerManagement.enable = false;
      powerManagement.finegrained = false;

      # Set Driver Package
      package = config.boot.kernelPackages.nvidiaPackages."${config.systemModules.nvidia.driver}";
    };
  };
}
