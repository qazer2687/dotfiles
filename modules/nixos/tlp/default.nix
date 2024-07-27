{
  lib,
  config,
  pkgs,
  ...
}: {
  options.modules.tlp.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.tlp.enable {
    services.tlp = {
      enable = true;
      settings = {
        CPU_SCALING_GOVERNOR_ON_AC = "performance";
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
        CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
        CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
        TLP_DEFAULT_MODE = "BAT";
        USB_AUTOSUSPEND = 1;
        TLP_PERSISTENT_DEFAULT = 0; # more power when plugged in
        RUNTIME_PM_ALL = 1;
        SOUND_POWER_SAVE_ON_AC = 1;
        SOUND_POWER_SAVE_ON_BAT = 1;
        MEM_SLEEP_ON_AC = "deep";
        MEM_SLEEP_ON_BAT = "deep";
        WIFI_PWR_ON_AC = "on";
        WIFI_PWR_ON_BAT = "on";
        CPU_MIN_PERF_ON_AC = 100; # experimental
        CPU_MAX_PERF_ON_AC = 100;
        CPU_MIN_PERF_ON_BAT = 0;
        CPU_MAX_PERF_ON_BAT = 100;
      };
    };
  };
}
