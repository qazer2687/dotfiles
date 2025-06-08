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
      capSysNice = true;
      args = [
        "-w 2560" # width
        "-h 1440" # height
        "-S stretch" # scaling
        "-f" # fullscreen
        "-e" # steam integration
      ];
    };
  };
}
