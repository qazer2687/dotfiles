{
  lib,
  config,
  ...
}: {
  options.modules.nvidia.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.nvidia.enable {
    hardware.graphics.enable = true;
    hardware.nvidia = {
      # Modesetting is required.
      modesetting.enable = true;

      # Don't use the nvidia open source kernel module
      # as it breaks nvidia-ctk and nvidia-smi.
      open = false;

      # Enable the nvidia settings menu.
      nvidiaSettings = true;

      package = config.boot.kernelPackages.nvidiaPackages.stable;
    };
    
    services.xserver = {
      videoDrivers = [ "nvidia" ];
    };
  };
}
