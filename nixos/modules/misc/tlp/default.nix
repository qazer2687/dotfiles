{
  lib,
  config,
  ...
}: {
  options.systemModules.misc.tlp.enable = lib.mkEnableOption "";
  # Configuration
  config = lib.mkIf config.systemModules.misc.tlp.enable {
    services.tlp.enable = true;
  };
}
