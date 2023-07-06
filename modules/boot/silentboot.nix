{ inputs, lib, config, pkgs, ... }:
{
  options.modules.boot.silentboot.enable = lib.mkEnableOption "";
  config = lib.mkIf config.modules.boot.silentboot.enable {
    environment.etc = {
      "issue" = {
        text = "[?12l[?25h";
        mode = "0444";
      };
    };

    boot = {
      blacklistedKernelModules = ["pcspkr"]; # stop beep on boot
      kernelParams = [
        "quiet"
        "systemd.show_status=false"
        "rd.udev.log_level=0"
        "vt.global_cursor_default=0"
        "acpi_backlight=vendor"
      ];
      consoleLogLevel = 0;
      initrd.verbose = false;
    };
  };
}

