{
  lib,
  config,
  ...
}: {
  options.systemModules.tlp.enable = lib.mkEnableOption "";
  # Configuration
  config = lib.mkIf config.systemModules.tlp.enable {
    services.tlp = {
      enable = true;
      settings = {
        TLP_ENABLE = 1;
        TLP_DEFAULT_MODE = "BAT";
        USB_AUTOSUSPEND = 1;
        TLP_PERSISTENT_DEFAULT = 1;
        RUNTIME_PM_ALL = 1;
        NMI_WATCHDOG = 0;
        MAX_LOST_WORK_SECS_ON_AC = 60;
        MAX_LOST_WORK_SECS_ON_BAT = 60;
        SOUND_POWER_SAVE_ON_AC = 1;
        SOUND_POWER_SAVE_ON_BAT = 1;
        MEM_SLEEP_ON_AC = "deep";
        MEM_SLEEP_ON_BAT = "deep";
        WIFI_PWR_ON_AC = "on";
        WIFI_PWR_ON_BAT = "on";
      };
    };
  };
}
