{
  lib,
  config,
  ...
}: { 

  options.systemModules.zram.enable = lib.mkEnableOption "";

  options.systemModules.zram.percentage = lib.mkOption {
    default = 0;
    type = lib.types.int;
    description = "Choose zram percentage. (0 .. 100)";
  };

  config = lib.mkIf config.systemModules.zram.enable {
    zramSwap = {
      enable = true;
      algorithm = "zstd";
    };
  };
  systemModules.kernel.type = {
    zramSwap = {
      memoryPercent = "${config.systemModules.zram.percentage}";
    };
  };
}
