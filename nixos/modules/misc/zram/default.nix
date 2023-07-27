{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  options.systemModules.misc.zram.enable = lib.mkEnableOption "";

  config = lib.mkIf config.systemModules.misc.zram.enable {
    zramSwap = {
      enable = true;
      algorithm = "zstd";
      memoryPercent = 25;
    };
  };
}
