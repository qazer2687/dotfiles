{
  lib,
  config,
  pkgs,
  ...
}: {
  options.homeModules.lutris.enable = lib.mkEnableOption "";

  config = lib.mkIf config.homeModules.starship.enable {
    environment.systemPackages = with pkgs; [
      lutris
    ];
  };
}
