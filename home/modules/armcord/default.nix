{
  lib,
  config,
  pkgs,
  ...
}: {
  options.homeModules.armcord.enable = lib.mkEnableOption "";

  config = lib.mkIf config.homeModules.armcord.enable {
    home.packages = with pkgs; [
      armcord
    ];
  };
}
