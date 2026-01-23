{
  lib,
  config,
  pkgs,
  ...
}: {
  options.modules.gamemode.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.gamemode.enable {
    programs.gamemode = {
      enable = true;
      enableRenice = true;
      settings = {
        general = {
          # As my CPU cooling solution isn't the best, this theoretically
          # should perform a bit better than the 'performance' governor.
          desiredgov = "schedutil";
          defaultgov = "schedutil";
          renice = 15;
          ioprio = 0;
          inhibit_screensaver = 1;
          # From play.nix flake.
          softrealtime = "auto";
        };
        gpu = {
          apply_gpu_optimisations = "accept-responsibility";
          gpu_device = 0;
          intel_gpu_boost = 1;
        };
        custom = {
          start = "${pkgs.libnotify}/bin/notify-send 'GameMode' 'Activated'";
          end = "${pkgs.libnotify}/bin/notify-send 'GameMode' 'Deactivated'";
        };
      };
    };

    # Ensure user is in gamemode group for proper permissions.
    users.users.alex.extraGroups = ["gamemode"];
  };
}
