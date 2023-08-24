{
  lib,
  config,
  ...
}: {
  options.systemModules.opengl.enable = lib.mkEnableOption "";
  config = lib.mkIf config.systemModules.opengl.enable {
    hardware.opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };
  };
}