{
  lib,
  config,
  ...
}: {
  options.modules.systemd-boot.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.systemd-boot.enable {
    # Required by asahi.
    boot.loader.efi.canTouchEfiVariables = false;
    boot.loader.systemd-boot.enable = true;
    # Pressing ESC on boot will bring up the bootloader menu.
    boot.loader.timeout = 0;
    # Hide cursor.
    environment.etc = {
      "issue" = {
        text = "[?12l[?25h";
        mode = "0444";
      };
    };
  };
}
