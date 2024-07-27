{
  lib,
  config,
  pkgs,
  ...
}: {
  options.modules.waydroid.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.waydroid.enable {
    virtualisation.waydroid.enable = true;
  };
}
