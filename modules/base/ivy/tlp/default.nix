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
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
        CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
        
        CPU_MIN_PERF_ON_AC = 100;
        CPU_MAX_PERF_ON_AC = 100;
        CPU_MIN_PERF_ON_BAT = 0;
        CPU_MAX_PERF_ON_BAT = 50;
        
        CPU_BOOST_ON_AC = 1;
        CPU_BOOST_ON_BAT = 0;

        INTEL_GPU_MIN_FREQ_ON_AC = 1050;
        INTEL_GPU_MAX_FREQ_ON_AC = 1050;
        INTEL_GPU_BOOST_FREQ_ON_AC = 1050;
        
        # Battery: allow 300-650MHz range for power savings
        INTEL_GPU_MIN_FREQ_ON_BAT = 300;
        INTEL_GPU_MAX_FREQ_ON_BAT = 650;
        INTEL_GPU_BOOST_FREQ_ON_BAT = 650;
      
        PCIE_ASPM_ON_AC = "performance";
        PCIE_ASPM_ON_BAT = "powersupersave";

        RUNTIME_PM_ON_AC = "on";
        RUNTIME_PM_ON_BAT = "auto";
      };
    };
  };
}
