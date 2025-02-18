{
  lib,
  config,
  ...
}: {
  options.modules.zram.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.zram.enable {
    zramSwap = {
      # Marcan said something about it being ineffective on apple silicon.
      enable = false;
      algorithm = "zstd";
      memoryPercent = 50;
    };
  };
}
