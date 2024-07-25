{
  lib,
  config,
  pkgs,
  ...
}: {
  options.modules.nvidia.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.nvidia.enable {
    services.xserver.videoDrivers = ["nvidia"];
    hardware.nvidia = {
      modesetting.enable = true;
      open = false;
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.latest;
    };
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
          gpu_device = 0;
          nv_powermizer_mode = 1; # "Prefer Maximum Performance"
        };
        custom = {
          start = "${pkgs.libnotify}/bin/notify-send 'GameMode Enabled'";
          end = "${pkgs.libnotify}/bin/notify-send 'GameMode Disabled'";
        };
      };
    };
  };
}
