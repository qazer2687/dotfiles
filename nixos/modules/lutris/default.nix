{
  lib,
  config,
  pkgs,
  ...
}: {
  options.homeModules.lutris.enable = lib.mkEnableOption "";

  config = lib.mkIf config.homeModules.lutris.enable {
    environment.systemPackages = with pkgs; [
      lutris
    ];
  };
}
