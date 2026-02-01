{
  lib,
  config,
  pkgs,
  ...
}: {
  options.modules.amdgpu.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.amdgpu.enable {
    hardware.graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
        rocmPackages.clr.icd
        libva-vdpau-driver
        libvdpau-va-gl
        mesa
      ];
      extraPackages32 = with pkgs.driversi686Linux; [
        libva-vdpau-driver
        libvdpau-va-gl
        mesa
      ];
    };

    environment.systemPackages = with pkgs; [
      vulkan-tools
      vulkan-loader
      vulkan-validation-layers
      vulkan-extension-layer
    ];

    services.xserver.videoDrivers = ["modesetting"];

    hardware.amdgpu = {
      initrd.enable = true;
      opencl.enable = true;
    };

    # Control Panel
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
