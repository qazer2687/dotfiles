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
        "fbcon=nodefer"
        "loglevel=0"
        "bgrt_disable"
        "quiet"
        "systemd.show_status=false"
        "rd.udev.log_level=0"
        "vt.global_cursor_default=0"
        "vsyscall=none"
        "acpi_call"
        "lockdown=confidentiality"
        "page_alloc.shuffle=1"
        "iommu=pt"
        "lsm=landlock,lockdown,yama,apparmor,bpf"
        "logo.nologo"
        "acpi_backlight=vendor"
      ];
      consoleLogLevel = 0;
      initrd.verbose = false;
    };
  };
}

