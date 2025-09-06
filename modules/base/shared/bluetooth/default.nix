{
  lib,
  config,
  ...
}: {
  options.modules.bluetooth.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.bluetooth.enable {
    hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
    services.blueman.enable = true;
  };
}
