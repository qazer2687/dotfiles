{
  lib,
  config,
  pkgs,
  ...
}: {
  options.modules.nvidia.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.nvidia.enable {
    boot = {
      kernelParams = ["nvidia-drm.modeset=1"];
    };
    services.xserver.videoDrivers = ["nvidia"];
    hardware = {
      nvidia = {
        package = config.boot.kernelPackages.nvidiaPackages.vulkan_beta;
        modesetting.enable = true;
        open = false;
        nvidiaSettings = true;
      };
    };

    # gamescope
    programs.gamescope = {
      enable = true;
      args = [
        "-w 1720" # width
        "-h 1080" # height
        "-S stretch" # scaling
        "-f" # fullscreen
        "-e" # steam integration
      ];
    };

    # gamemode
    programs.gamemode = {
      enable = true;
      enableRenice = false;
      settings = {
        general = {
          desiredgov = "performance";
          defaultgov = "powersave";
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
