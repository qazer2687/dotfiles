{
  lib,
  config,
  pkgs,
  ...
}: {
  options.modules.steam.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.steam.enable {
    programs.steam = {
      enable = true;
      gamescopeSession.enable = true;
    };
    programs.gamescope = {
      enable = true;
    };
  };
}
