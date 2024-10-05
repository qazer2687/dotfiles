{
  lib,
  config,
  ...
}: {
  options.modules.minecraft.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.minecraft.enable {
    
  };
}
