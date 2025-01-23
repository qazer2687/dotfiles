{
  lib,
  config,
  ...
}: {
  options.modules.server.minecraft.enable = lib.mkEnableOption "";

  config =
    lib.mkIf config.modules.server.minecraft.enable {
    };
}
