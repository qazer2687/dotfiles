{
  lib,
  config,
  pkgs,
  inputs,
  base16,
  ...
}: let
  scheme = base16 "gruvbox-dark-hard";
in {
  options.modules.niri.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.niri.enable {
    programs.niri = {
      enable = true;
      package = inputs.niri.packages.${pkgs.system}.niri-stable;
      settings = {
        hotkey-overlay.skip-at-startup = true;
        prefer-no-csd = true;

        input = {
          keyboard.xkb = {
            layout = "gb";
            variant = "colemak";
          };
          touchpad = {
            tap = false;
            # Enable palm rejection.
            dwt = true;
          };
          focus-follows-mouse = {
            enable = true;
          };
        };

        outputs."eDP-1".scale = 2.0;

        window-rules = [
          {
            clip-to-geometry = true;

            # The max width is 1280 as I use 2x scaling (2560 / 2).
            # This configuration leaves 20px on each side.
            min-width = 1240;
            max-width = 1240;

            # Rounded Corners
            /*
            geometry-corner-radius = {
              bottom-left = 4.0;
              bottom-right = 4.0;
              top-left = 4.0;
              top-right = 4.0;
            };
            */

            focus-ring = {
              enable = true;
              width = 1;
              active.color = "#${scheme.base05}";
              inactive.color = "#${scheme.base02}";
            };
          }
        ];

        layout = {
          gaps = 4;
          center-focused-column = "always";
        };

        workspaces."one" = {};
        workspaces."two" = {};
        workspaces."three" = {};
        workspaces."four" = {};
        workspaces."five" = {};
        workspaces."six" = {};
        workspaces."seven" = {};
        workspaces."eight" = {};
        workspaces."nine" = {};
        workspaces."ten" = {};


        binds = with config.lib.niri.actions; {
          # Terminal
          "Mod+Return".action = spawn "foot";

          # Application launcher
          "Mod+e".action = spawn "tofi-run" "|" "sh";

          # Overview
          "Mod+Space".action = toggle-overview;

          # Window management
          "Mod+q".action = close-window;
          "Mod+Shift+f".action = toggle-window-floating;
          "Mod+t".action = fullscreen-window;

          # Volume controls
          "XF86AudioRaiseVolume".action = spawn "${pkgs.pamixer}/bin/pamixer" "-i" "5";
          "XF86AudioLowerVolume".action = spawn "${pkgs.pamixer}/bin/pamixer" "-d" "5";
          "XF86AudioMute".action = spawn "${pkgs.pamixer}/bin/pamixer" "-t";
          "XF86AudioMicMute".action = spawn "${pkgs.pamixer}/bin/pamixer" "--default-source" "-t";

          # Brightness controls
          "XF86MonBrightnessUp".action = spawn "${pkgs.brightnessctl}/bin/brightnessctl" "s" "1%+";
          "XF86MonBrightnessDown".action = spawn "${pkgs.brightnessctl}/bin/brightnessctl" "s" "1%-";

          # Keyboard backlight
          "Mod+XF86MonBrightnessUp".action = spawn "${pkgs.brightnessctl}/bin/brightnessctl" "--class" "leds" "--device" "kbd_backlight" "set" "10%+";
          "Mod+XF86MonBrightnessDown".action = spawn "${pkgs.brightnessctl}/bin/brightnessctl" "--class" "leds" "--device" "kbd_backlight" "set" "10%-";

          # Window movement
          "Mod+left".action = move-column-left;
          "Mod+right".action = move-column-right;
          "Mod+up".action = move-window-up;
          "Mod+down".action = move-window-down;

          # Window Resizing
          #"Mod+Shift+right".action = set-window-width "+10%";
          #"Mod+Shift+left".action = set-window-width "-10%";

          # Workspace switching
          "Mod+1".action = focus-workspace "one";
          "Mod+2".action = focus-workspace "two";
          "Mod+3".action = focus-workspace "three";
          "Mod+4".action = focus-workspace "four";
          "Mod+5".action = focus-workspace "five";
          "Mod+6".action = focus-workspace "six";
          "Mod+7".action = focus-workspace "seven";
          "Mod+8".action = focus-workspace "eight";
          "Mod+9".action = focus-workspace "nine";
          "Mod+0".action = focus-workspace "ten";

          # Move windows to workspaces
          "Mod+Shift+1".action.move-window-to-workspace = "one";
          "Mod+Shift+2".action.move-window-to-workspace = "two";
          "Mod+Shift+3".action.move-window-to-workspace = "three";
          "Mod+Shift+4".action.move-window-to-workspace = "four";
          "Mod+Shift+5".action.move-window-to-workspace = "five";
          "Mod+Shift+6".action.move-window-to-workspace = "six";
          "Mod+Shift+7".action.move-window-to-workspace = "seven";
          "Mod+Shift+8".action.move-window-to-workspace = "eight";
          "Mod+Shift+9".action.move-window-to-workspace = "nine";
          "Mod+Shift+0".action.move-window-to-workspace = "ten";


          # Screenshot
          #"Mod+Option".action = spawn "screenshot";
        };

        debug = {
          # Fixes a black screen bug on Asahi.
          # https://github.com/YaLTeR/niri/wiki/Getting-Started#asahi-arm-and-other-kmsro-devices
          render-drm-device = "/dev/dri/card1";
        };

        spawn-at-startup = [
          # This isn't possible yet on Asahi.
          # { command = [ "gammastep" "-t" "6500:3000" ]; }

          # Swww is great but the hit on battery life is too much for a laptop.
          # { command = [ "swww-daemon" ]; }
          # { command = [ "swww" "img" "/home/alex/.config/wallpaper/wallpaper.gif" ]; }

          {command = ["hyprlock" "-q" "||" "loginctl" "terminate-session" "$XDG_SESSION_ID"];}

          {command = ["fish" "-c" "'waybar'"];}

          {command = ["${pkgs.wbg}/bin/wbg" "-s" "/home/alex/.config/wallpaper/wallpaper.png"];}
        ];
      };
    };
  };
}
