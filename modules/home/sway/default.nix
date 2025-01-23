{
  lib,
  config,
  pkgs,
  ...
}: let
  modifier = "Mod4";

  screenshot = pkgs.writeShellApplication {
    name = "screenshot";
    runtimeInputs = with pkgs; [
      grim
      slurp
      wl-clipboard
    ];
    text = ''
      grim -g "$(slurp -b 00000055 -c ffffffff)" - | wl-copy -t image/png
    '';
  };
in {
  options.modules.sway.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.sway.enable {
    home.packages = with pkgs; [
      # This is a dependency of Mako.
      libnotify
      screenshot
    ];

    wayland.windowManager.sway = {
      enable = true;
      #package = pkgs.swayfx.overrideAttrs (_old: {passthru.providedSessions = ["sway"];});
      # Not sure what the performance impact is with swayfx, I will just use sway for now.
      # The only "effect" I use is rounded corners but these aren't so important to me and
      # end up cutting off tabs in firefox which looks like shit.
      package = pkgs.swayfx.overrideAttrs (_old: {passthru.providedSessions = ["sway"];});
      checkConfig = false;
      config = {
        inherit modifier;

        gaps = {
          inner = 6;
          outer = 0;
        };

        input = {
          "TPPS/2 IBM TrackPoint" = {
            pointer_accel = "0.8";
            accel_profile = "flat";
            tap = "enabled";
          };
          "type:touchpad" = {
            tap = "disabled";
          };
          "type:keyboard" = {
            xkb_layout = "gb";
            xkb_variant = "colemak";
          };
        };

        # Bar
        bars = lib.mkForce [];

        # Display & Wallpaper
        output = {
          "*".bg = "~/.config/wallpaper/wallpaper.png fill";
          # Settings for my external Asus monitor.
          "DP-1".mode = "2560x1440@143.972000Hz";
          # Settings for the internal display on Jet.
          "eDP-1".mode = "2560x1664@60Hz scale 2";
        };

        # Decorations
        window = {
          titlebar = false;
          # Disable border while using rounded corners.
          border = 1;
        };

        colors = {
          focused = {
            background = "#ffffff";
            border = "#ffffff";
            childBorder = "#ffffff";
            indicator = "#ffffff";
            text = "#ffffff";
          };
        };

        keybindings = lib.mkOptionDefault rec {
          # Open Terminal
          "${modifier}+Return" = "exec foot";

          # Close Window
          "${modifier}+q" = "kill";

          # Reload
          "${modifier}+Shift+r" = "reload";

          # Search
          "${modifier}+e" = "exec wofi --show drun";

          # Floating
          "${modifier}+space" = "floating toggle";

          # Screenshot
          "Print" = "exec ${lib.getExe screenshot}";

          # Volume Controls
          XF86AudioRaiseVolume = "exec ${pkgs.pamixer}/bin/pamixer -i 5";
          XF86AudioLowerVolume = " exec ${pkgs.pamixer}/bin/pamixer -d 5";
          XF86AudioMute = "exec ${pkgs.pamixer}/bin/pamixer -t";
          XF86AudioMicMute = "exec ${pkgs.pamixer}/bin/pamixer --default-source -t";

          # Brightness Controls
          XF86MonBrightnessUp = "exec ${pkgs.brightnessctl}/bin/brightnessctl set 1%+";
          XF86MonBrightnessDown = "exec ${pkgs.brightnessctl}/bin/brightnessctl set 1%-";

          # Backlight Controls
          "${modifier}+XF86MonBrightnessUp" = "exec ${pkgs.brightnessctl}/bin/brightnessctl  --class leds --device kbd_backlight set 10%+";
          "${modifier}+XF86MonBrightnessDown" = "exec ${pkgs.brightnessctl}/bin/brightnessctl  --class leds --device kbd_backlight set 10%-";

          # Workspace Navigation
          "${modifier}+1" = "workspace number 1";
          "${modifier}+2" = "workspace number 2";
          "${modifier}+3" = "workspace number 3";
          "${modifier}+4" = "workspace number 4";
          "${modifier}+5" = "workspace number 5";
          "${modifier}+6" = "workspace number 6";
          "${modifier}+7" = "workspace number 7";
          "${modifier}+8" = "workspace number 8";
          "${modifier}+9" = "workspace number 9";

          # Workspace Manipulation
          "${modifier}+Shift+1" = "move container to workspace number 1";
          "${modifier}+Shift+2" = "move container to workspace number 2";
          "${modifier}+Shift+3" = "move container to workspace number 3";
          "${modifier}+Shift+4" = "move container to workspace number 4";
          "${modifier}+Shift+5" = "move container to workspace number 5";
          "${modifier}+Shift+6" = "move container to workspace number 6";
          "${modifier}+Shift+7" = "move container to workspace number 7";
          "${modifier}+Shift+8" = "move container to workspace number 8";
          "${modifier}+Shift+9" = "move container to workspace number 9";

          # Move
          "${modifier}+Left" = "move left";
          "${modifier}+Down" = "move down";
          "${modifier}+Up" = "move up";
          "${modifier}+Right" = "move right";

          # Resize
          "${modifier}+Shift+Left" = "resize shrink width 5 ppt";
          "${modifier}+Shift+Up" = "resize grow height 5 ppt";
          "${modifier}+Shift+Down" = "resize shrink height 5 ppt";
          "${modifier}+Shift+Right" = "resize grow width 5 ppt";
        };
      };

      extraConfig = ''
        # Corner Radius
        # Make sure to turn off borders while using this, as the borders do not conform to this setting.
        #corner_radius 6

        # Smart Gaps
        #smart_gaps on

        # Eye Comfort
        # Gammastep currently doesn't work on Asahi Linux.
        # exec gammastep -xO 3000

        # Waybar
        bar {
          swaybar_command waybar
        }

        # Move to workspace one on startup, because for some
        # reason it defaults to workspace ten on startup.
        exec swaymsg workspace 1
      '';

      wrapperFeatures = {
        base = true;
        gtk = true;
      };
    };
  };
}
