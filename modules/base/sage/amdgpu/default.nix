{
  lib,
  config,
  pkgs,
  ...
}: {
  options.modules.amdgpu.enable = lib.mkEnableOption "AMD GPU Support";

  config = lib.mkIf config.modules.amdgpu.enable {
    hardware.graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
        rocmPackages.clr.icd
        libva
        libva-utils
        amdgpu_top
      ];
      extraPackages32 = with pkgs.pkgsi686Linux; [
        libva
      ];
    };

    environment.systemPackages = with pkgs; [
      vulkan-tools
      vulkan-loader
      nvtopPackages.amd
    ];

    services.xserver.videoDrivers = ["amdgpu"];

    hardware.amdgpu = {
      initrd.enable = true;
      opencl.enable = true;
    };

    services.lact.enable = true;

    boot.kernelParams = [
      "amdgpu.dcdebugmask=0x10"
      "amdgpu.disp_priority=2"
      "amdgpu.gpu_recovery=1"
    ];
  };
}