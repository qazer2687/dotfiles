{
  lib,
  config,
  ...
}: {
  options.modules.clamav.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.clamav.enable {
    services.clamav = {
      daemon.enable = true;
      updater.enable = true;
      updater.frequency = 24;
      updater.interval = "hourly";
    };
  };
}
