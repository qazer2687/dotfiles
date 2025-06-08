{
  lib,
  config,
  ...
}: {
  options.modules.gamemode.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.gamemode.enable {
    programs.gamemode = {
      enable = true;
      enableRenice = true;
      settings = {
        general = {
          desiredgov = "performance";
          defaultgov = "performance";
        };
        gpu = {
          apply_gpu_optimisations = "accept-responsibility";
          # This is /sys/class/drm/card<x>.
          gpu_device = 1;
          nv_powermizer_mode = 1; # "Prefer Maximum Performance"
        };
      };
    };
  };
}
