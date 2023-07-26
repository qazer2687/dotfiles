{ inputs, lib, config, pkgs, ... }: {

  options.modules.system.kernel.enable = lib.mkEnableOption "";
  
  config = lib.mkIf config.modules.system.kernel.enable {
    boot = {
      # Disable MOBO Beep & Bluetooth
      blacklistedKernelModules = ["pcspkr" "btusb" "bluetooth"]; 

      # Silence Boot Stage
      kernelParams = ["fbcon=nodefer" "bgrt_disable" "quiet" "systemd.show_status=false" "rd.udev.log_level=0" "vt.global_cursor_default=0"];
      consoleLogLevel = 0;
      initrd.verbose = false;

      # Zen Kernel
      kernelPackages = pkgs.linuxPackages_zen;
    };
  };
}
