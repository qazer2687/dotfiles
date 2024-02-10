{
  lib,
  config,
  ...
}: {
  options.modules.fstrim.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.fstrim.enable {
    services.fstrim.enable = true;
  };
}
