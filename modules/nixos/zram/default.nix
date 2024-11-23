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
      # Add a writeback device for uncompressable files.
      memoryPercent = 100;
    };
  };
}
