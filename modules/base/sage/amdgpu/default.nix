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
    services.lact.enable = true;
    # Potential fix for black screen issues.
    boot.kernelParams = ["amdgpu.gfxoff=0" "amdgpu.gpu_recovery=1" "noretry=0"];
  };
}
