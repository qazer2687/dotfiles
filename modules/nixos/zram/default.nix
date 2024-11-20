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
      # I can use 100% but will this result in a lot of CPU for compression irrelevant things?
      memoryPercent = 80;
    };
  };
}
