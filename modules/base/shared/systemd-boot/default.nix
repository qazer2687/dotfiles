{
  lib,
  config,
  pkgs,
  inputs,
  ...
}: {
  options.modules.systemd-boot.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.systemd-boot.enable {
    boot.loader.systemd-boot.enable = true;
    # Pressing ESC on boot will bring up the bootloader menu.
    boot.loader.timeout = 0;
    environment.etc = {
      "issue" = {
        text = "[?12l[?25h";
        mode = "0444";
      };
    };
  };
}
