{
  lib,
  config,
  pkgs,
  ...
}: {
  options.systemModules.lutris.enable = lib.mkEnableOption "";

  config = lib.mkIf config.systemModules.lutris.enable {
    environment.systemPackages = with pkgs; [
      lutris
    ];
  };
}
