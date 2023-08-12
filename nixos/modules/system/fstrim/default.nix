{
  lib,
  config,
  ...
}: {
  options.systemModules.system.fstrim.enable = lib.mkEnableOption "";

  # udev rule for letting via discover keyboards
  config = lib.mkIf config.systemModules.system.fstrim.enable {
    services.fstrim.enable = true;
  };
}
