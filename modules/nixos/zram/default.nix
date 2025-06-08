{
  lib,
  config,
  ...
}: {
  options.modules.zram.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.zram.enable {
    zramSwap = {
      enable = true;
      algorithm = "zstd";
      # Provides 2GB "extra" RAM with 8GB physical.
      memoryPercent = 25;
    };
  };
}
