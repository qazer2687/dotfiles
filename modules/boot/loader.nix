{ inputs, lib, config, pkgs, ... }:
{
  options.modules.boot.loader.enable = lib.mkEnableOption "";
  config = lib.mkIf config.modules.boot.loader.enable {
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;
    boot.loader.efi.efiSysMountPoint = "/boot/efi";
    boot.loader.timeout = 0;
  };

  options.modules.boot.loader.silent = lib.mkEnableOption "";
  config = lib.mkIf config.modules.boot.loader.silent {
    imports = [ ./stage2patch.nix ];

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
