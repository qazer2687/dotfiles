{
  lib,
  config,
  ...
}: {
  options.modules.tlp.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.tlp.enable {
    services.tlp = {
      enable = true;
      settings = {
        CPU_SCALING_GOVERNOR_ON_AC = "performance";
        CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
        SOUND_POWER_SAVE_ON_AC = 1;
        MEM_SLEEP_ON_AC = "deep";
        WIFI_PWR_ON_AC = "on";
        CPU_MIN_PERF_ON_AC = 0;
        CPU_MAX_PERF_ON_AC = 100;

        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
        CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
        SOUND_POWER_SAVE_ON_BAT = 1;
        MEM_SLEEP_ON_BAT = "deep";
        WIFI_PWR_ON_BAT = "on";
        CPU_MIN_PERF_ON_BAT = 0;
        CPU_MAX_PERF_ON_BAT = 100;

        TLP_DEFAULT_MODE = "BAT";
        USB_AUTOSUSPEND = 1;
        TLP_PERSISTENT_DEFAULT = 0;
        RUNTIME_PM_ALL = 1;
        NMI_WATCHDOG = 0;
      };
    };
  };
}
