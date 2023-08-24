{
  lib,
  config,
  ...
}: {
  options.systemModules.auto-cpufreq.enable = lib.mkEnableOption "";

  config = lib.mkIf config.systemModules.auto-cpufreq.enable {
    services.auto-cpufreq = {
      enable = true;
      #settings = builtins.readFile ./config/laptop;
    };
  };
}
