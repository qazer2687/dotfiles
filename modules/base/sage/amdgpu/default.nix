{
  lib,
  config,
  ...
}: {
  options.modules.amdgpu.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.amdgpu.enable {
    hardware.graphics = {
      enable = true;
      enable32Bit = true;
    };
    services.xserver.videoDrivers = [ "modesetting" ];
    hardware.amdgpu.initrd.enable = true;
    services.lact.enable = true;
    # Potential fix for black screen issues.
    boot.kernelParams = [
      "amdgpu.gfxoff=0"
      "amdgpu.gpu_recovery=1"
      "noretry=0"
      "split_lock_detect=off"
      "amdgpu.ppfeaturemask=0xfffd3fff"
    ];
  };
}
