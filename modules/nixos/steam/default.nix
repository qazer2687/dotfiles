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
    };

    programs.gamescope = {
      enable = true;
      capSysNice = false;
      args = [
        "-w 2560" # width
        "-h 1080" # height
        "-S stretch" # scaling
        "-f" # fullscreen
        "-e" # steam integration
      ];
    };
  };
}
