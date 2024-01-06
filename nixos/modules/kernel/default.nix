{
  lib,
  config,
  pkgs,
  ...
}: {
  options.systemModules.kernel.enable = lib.mkEnableOption "";

  config = lib.mkIf config.systemModules.kernel.enable {
    boot = {
      blacklistedKernelModules = ["pcspkr" "btusb" "bluetooth"];
      kernelParams = ["fbcon=nodefer" "bgrt_disable" "quiet" "systemd.show_status=false" "rd.udev.log_level=0" "vt.global_cursor_default=0"];
      consoleLogLevel = 0;
      initrd.verbose = false;
      kernelPackages = pkgs.linuxPackages_latest;
    };
  };
}
