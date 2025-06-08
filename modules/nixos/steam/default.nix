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
      # This option does not work, enabling will cause games to fail on launch.
      capSysNice = false;
      args = [
        "-w 2560" # width
        "-h 1440" # height
        "-S stretch" # scaling
        "-f" # fullscreen
        # This option only works if steam is launched within the gamescope session,
        # otherwise the gamescope session will be invisible.
        #"-e" # steam integration
      ];
    };
  };
}
