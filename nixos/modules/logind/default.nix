{
  lib,
  config,
  ...
}: {
  options.systemModules.logind.enable = lib.mkEnableOption "";

  config = lib.mkIf config.systemModules.logind.enable {
    services.logind = {
      extraConfig = ''
      HandlePowerKey=ignore
    '';
    };
  };
}
