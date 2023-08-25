{
  lib,
  config,
  ...
}: {
  options.systemModules.auto-cpufreq.enable = lib.mkEnableOption "";

  config = lib.mkIf config.systemModules.auto-cpufreq.enable {
    services.auto-cpufreq = {
      enable = true;
      settings = {
        charger = {
          governor = "performance";
          scaling_min_freq = 1700000;
          scaling_max_freq = 2000000;
          turbo = "auto";
        };
        battery = {
          governor = "powersave";
          scaling_min_freq = 800000;
          scaling_max_freq = 1000000;
          turbo = "never";
        };
      };
    };
  };
}
