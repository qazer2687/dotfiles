{
  lib,
  config,
  ...
}: {
  options.modules.zram.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.zram.enable {
    
    boot.kernel.sysctl = {
      # Ensure all uncompressed ram is used first.
      "vm.swappiness" = 25;
    };
    
    zramSwap = {
      enable = true;
      algorithm = "lz4";
      # Provides 4GB "extra" RAM with 8GB physical.
      memoryPercent = 50;
    };
  };
}
