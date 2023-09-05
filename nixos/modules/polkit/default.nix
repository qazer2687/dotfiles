{
  lib,
  config,
  ...
}: {
  options.systemModules.polkit.enable = lib.mkEnableOption "";

  config = lib.mkIf config.systemModules.polkit.enable {
    security.polkit.enable = true;
  };
}
