{
  lib,
  config,
  ...
}: {
  options.systemModules.fstrim.enable = lib.mkEnableOption "";

  # udev rule for letting via discover keyboards
  config = lib.mkIf config.systemModules.fstrim.enable {
    services.fstrim.enable = true;
  };
}
