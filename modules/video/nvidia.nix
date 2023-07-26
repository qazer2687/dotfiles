{ inputs, lib, config, pkgs, ... }: {

  options.modules.video.nvidia.enable = lib.mkEnableOption "";
  
  config = lib.mkIf config.modules.video.nvidia.enable {
    services.xserver.videoDrivers = ["nvidia"];
    hardware.nvidia = {
      modesetting.enable = false;
      open = false;
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.stable;
    };
    hardware.opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };
  };
}


