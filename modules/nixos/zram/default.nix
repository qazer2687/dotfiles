{
  lib,
  config,
  pkgs,
  ...
}: {
  options.modules.zram.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.zram.enable {
    zramSwap = {
      enable = true;
      algorithm = "zstd";
      memoryPercent = 50;
    };
  };
}
