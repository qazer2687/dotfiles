{ inputs, lib, config, pkgs, ... }: {
  
  environment.etc = {
    "issue" = {
      text = "[?12l[?25h";
      mode = "0444";
    };
  };
  boot = {
    blacklistedKernelModules = ["pcspkr"]; 
    kernelParams = ["fbcon=nodefer" "bgrt_disable" "quiet" "systemd.show_status=false" "rd.udev.log_level=0" "vt.global_cursor_default=0"];
    consoleLogLevel = 0;
    initrd.verbose = false;
  };
}