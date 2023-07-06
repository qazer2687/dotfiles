{ inputs, lib, config, pkgs, ... }: {
  options.modules.boot.systemd-boot.enable = lib.mkEnableOption "";
  options.modules.boot.systemd-boot.silentboot.enable = lib.mkEnableOption "";

  config = lib.mkMerge [
    (lib.mkIf config.modules.boot.systemd-boot.enable {
      boot.loader.systemd-boot.enable = true;
      boot.loader.efi.canTouchEfiVariables = true;
      boot.loader.efi.efiSysMountPoint = "/boot/efi";
      boot.loader.timeout = 0;
    })
    (lib.mkIf config.modules.boot.systemd-boot.silentboot.enable {
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
    })
  ];
}
