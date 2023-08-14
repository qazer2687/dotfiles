{
  lib,
  config,
  pkgs,
  ...
}: {
  options.systemModules.i3.enable = lib.mkEnableOption "";

  config = lib.mkIf config.systemModules.i3.enable {
    services.xserver = {
      windowManager.i3 = {
        enable = true;
        package = pkgs.i3-rounded;
      };
    };
  };
}
