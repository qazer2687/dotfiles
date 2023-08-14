{
  lib,
  config,
  ...
}: {
  options.systemModules.opendrop.enable = lib.mkEnableOption "";
  config = lib.mkIf config.systemModules.opendrop.enable {
    environment.systemPackages = with pkgs; [ opendrop ];
  };
}