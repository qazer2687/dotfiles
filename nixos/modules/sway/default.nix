{
  lib,
  config,
  pkgs,
  ...
}: {
  options.systemModules.sway.ruby.enable = lib.mkEnableOption "";
  # Configuration
  config = lib.mkIf config.systemModules.sway.ruby.enable {
    programs.sway = {
      enable = true;
      package = package = (pkgs.swayfx.overrideAttrs (old: { passthru.providedSessions = [ "sway" ]; }));
      extraPackages = with pkgs; [
        gammastep # Eye Comfort
        killall # Kill Programs
        brightnessctl # Backlight Control
        dmenu-wayland # Application Launcher
        mako # Notification Daemon
        pulseaudio # Volume Control
        fltk # Keymap Control
        nitch # System Stats
        pavucontrol # Audio GUI
        grim # Screenshot Tool
        wl-clipboard # Clipboard Tool
        # kanshi # Display Configuration
        # wofi # Application Launcher
        # swayidle # Lock Screen
        waybar # System Bar
        gnome.nautilus # File Explorer
        pamixer # Volume Bindings
      ];
    };
  };
}