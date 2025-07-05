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
      # This option does not work, enabling will cause games to fail on launch.
      capSysNice = false;
      env = {
        # Enable Gamescope WSI (Wayland Surface Interface) for proper Wayland integration.
        ENABLE_GAMESCOPE_WSI = "1";
        # Set the Wayland display name for Gamescope session.
        GAMESCOPE_WAYLAND_DISPLAY = "gamescope-0";
        # Force Proton to use SDL backend for better compatibility.
        PROTON_USE_SDL = "1";
        # Enable Proton Wayland support.
        PROTON_USE_WAYLAND = "1";
        # Set SDL to use Wayland video driver.
        SDL_VIDEODRIVER = "wayland";
        # Disable NVIDIA Optimus layer for better performance.
        DISABLE_LAYER_NV_OPTIMUS_1 = "1";
      };
      args = [
        # Use SDL backend for better compatibility.
        "--backend"
        "drm"
        # Set fade out duration in milliseconds.
        "--fade-out-duration"
        "200"
        # Run in fullscreen mode.
        "--fullscreen"
        # Enable immediate flips for reduced latency.
        "--immediate-flips"
        # Enable real-time scheduling priority.
        "--rt"
      ];
    };
    
    environment.systemPackages = [
      pkgs.gamescope-wsi_git
    ];
  };
}
