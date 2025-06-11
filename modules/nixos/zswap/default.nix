{
  lib,
  config,
  ...
}: {
  options.modules.zswap.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.zswap.enable {
    boot.kernel.sysctl = {
      "vm.swappiness" = 1;
    };
    
    boot.kernelParams = [
      "zswap.enabled=1"
      "zswap.compressor=lz4"
      "zswap.zpool=z3fold"
      "zswap.max_pool_percent=10"
    ];
  };
}
