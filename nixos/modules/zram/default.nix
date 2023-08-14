{
  lib,
  config,
  ...
}: {
  options.systemModules.zram.enable = lib.mkEnableOption "";

  config = lib.mkIf config.systemModules.zram.enable {
    zramSwap = {
      enable = true;
      algorithm = "zstd";
      memoryPercent = 20;
    };
  };
}
