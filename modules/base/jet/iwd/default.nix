{
  lib,
  config,
  ...
}: {
  options.modules.iwd.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.iwd.enable {
    networking.wireless.iwd = {
      enable = true;
      settings.General.EnableNetworkConfiguration = true;
    };
  };
}
