{
  lib,
  pkgs,
  config,
  ...
}: {
  options.systemModules.piper.enable = lib.mkEnableOption "";

  config = lib.mkIf config.systemModules.piper.enable {
    environment.systemPackages = with pkgs; [
      piper
    ];
    services.ratbagd.enable = true;
  };
}