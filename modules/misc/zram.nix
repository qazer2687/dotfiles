{ inputs, lib, config, pkgs, ... }:
{
  options.modules.misc.zram.enable = lib.mkEnableOption "";
  config = lib.mkIf config.modules.misc.zram.enable {
    zramSwap = {
      enable = true;
      algorithm = "zstd";
      memoryPercent = 25;
    };
  };
}