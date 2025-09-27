{
  lib,
  config,
  ...
}: {
  options.modules.netbird.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.netbird.enable {
    services.netbird.enable = true;
  };
}
