{
  lib,
  config,
  pkgs,
  ...
}: {
  options.modules.kernel.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.kernel.enable {
    boot = {
      blacklistedKernelModules = ["pcspkr"];
      kernelParams = [
        "fbcon=nodefer"
        "bgrt_disable"
        "quiet"
        "systemd.show_status=false"
        "rd.udev.log_level=0"
        "vt.global_cursor_default=0"
        #"nvidia_drm.fbdev=1"
        "nvidia-drm.modeset=1" # required by gamescope
        "mitigations=off"
        "kernel.nmi_watchdog=0"
        "vsyscall=emulate"
        "clearcpuid=304" # disable avx-512
        "clearcpuid=514" # disable umip (sgdt)
      ];
      consoleLogLevel = 0;
      initrd.verbose = false;
      supportedFilesystems = ["ntfs"];
      kernelPackages = pkgs.linuxPackages_zen;
    };
  };
}
