{
  lib,
  config,
  pkgs,
  ...
}: {

  options.systemModules.sway.enable = lib.mkEnableOption "";
  
  options.systemModules.sway.host = lib.mkOption {
    default = "";
    type = lib.types.str;
    description = "Choose the host-specific configuration. (e.g. 'jade' or 'ruby')";
  };

  config = lib.mkIf config.systemModules.sway.enable {
    programs.sway = {
      enable = true;

      # Use SwayFX Package
      package = pkgs.swayfx.overrideAttrs (_old: {passthru.providedSessions = ["sway"];});

      # Install Additional Packages
      extraPackages = with pkgs; [
        brightnessctl # Backlight Control
        dmenu-wayland # Application Launcher
        mako # Notification Daemon
        fltk # Keymap Control
        nitch # System Stats
        pavucontrol # Audio GUI
        grim # Screenshot Tool
        wl-clipboard # Clipboard Tool
        gnome.nautilus # File Explorer
        pamixer # Volume Bindings
      ];
    };

    # Copy Sway Configuration Into /etc
    environment.etc."sway/config".source = ./config/${config.systemModules.sway.host};
  
  };
}

