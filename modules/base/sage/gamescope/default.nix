{
  lib,
  config,
  pkgs,
  ...
}: {
  options.modules.gamescope.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.gamescope.enable {
    programs.gamescope = {
      enable = true;
      # Chaotic Nyx Package
      package = pkgs.gamescope_git;
      # This option does not work, enabling will cause games to fail on launch.
      capSysNice = false;
    };

    environment.systemPackages = [
      pkgs.gamescope-wsi_git
    ];
  };
}
