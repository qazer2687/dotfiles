{
  lib,
  config,
  ...
}: {
  options.systemModules.misc.tlp.enable = lib.mkEnableOption "";

  config = lib.mkIf config.systemModules.misc.tlp.enable {
    services.tlp.enable = true;
  };
}
