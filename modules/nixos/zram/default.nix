{
  lib,
  config,
  ...
}: {
  options.modules.zram.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.zram.enable {
    
    boot.kernel.sysctl = {
      "vm.swappiness" = 100;
    };
    
    zramSwap = {
      enable = true;
      algorithm = "lz4";
      # Provides 4GB "extra" RAM with 8GB physical.
      memoryPercent = 50;
    };
  };
}
