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
          desiredgov = "schedutil";
          defaultgov = "schedutil";
          renice = -10;
          ioprio = 0;
          inhibit_screensaver = 1;
        };
        gpu = {
          apply_gpu_optimisations = "accept-responsibility";
          gpu_device = 1;
          # Prefer maximum performance.
          nv_powermizer_mode = 1;
          # Set maximum GPU memory and core clocks.
          nv_core_clock_mhz_offset = 100;
          nv_mem_clock_mhz_offset = 500;
        };
        custom = {
          start = "${pkgs.libnotify}/bin/notify-send 'GameMode' 'Activated'";
          end = "${pkgs.libnotify}/bin/notify-send 'GameMode' 'Deactivated'";
        };
      };
    };
    
    # Ensure user is in gamemode group for proper permissions.
    users.users.alex.extraGroups = [ "gamemode" ];
    
    powerManagement.cpuFreqGovernor = lib.mkDefault "schedutil";
  };
}