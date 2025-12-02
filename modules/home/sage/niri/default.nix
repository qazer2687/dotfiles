{
  lib,
  config,
  pkgs,
  inputs,
  base16,
  ...
}: let
  scheme = base16 "framer";
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
            enable = false;
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

        /*
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
        */

        binds = with config.lib.niri.actions; {
          # Terminal
          "Mod+Return".action = spawn "foot";

          # Launcher
          "Mod+Space".action = spawn "bash" "-c" "tofi-run | xargs niri msg action spawn --";

          # Window Management
          "Mod+q".action = close-window;
          "Mod+Shift+f".action = toggle-window-floating;
          "Mod+f".action = fullscreen-window;
          "Mod+o".action = toggle-overview;

          # Volume Controls
          "XF86AudioRaiseVolume".action = spawn "${pkgs.pamixer}/bin/pamixer" "-i" "2";
          "XF86AudioLowerVolume".action = spawn "${pkgs.pamixer}/bin/pamixer" "-d" "2";
          "XF86AudioMute".action = spawn "${pkgs.pamixer}/bin/pamixer" "-t";
          "XF86AudioMicMute".action = spawn "${pkgs.pamixer}/bin/pamixer" "--default-source" "-t";

          # Brightness Controls
          "XF86MonBrightnessUp".action = spawn "${pkgs.brightnessctl}/bin/brightnessctl" "s" "1%+";
          "XF86MonBrightnessDown".action = spawn "${pkgs.brightnessctl}/bin/brightnessctl" "s" "1%-";

          # Keyboard Backlight
          "Mod+XF86MonBrightnessUp".action = spawn "${pkgs.brightnessctl}/bin/brightnessctl" "--class" "leds" "--device" "kbd_backlight" "set" "10%+";
          "Mod+XF86MonBrightnessDown".action = spawn "${pkgs.brightnessctl}/bin/brightnessctl" "--class" "leds" "--device" "kbd_backlight" "set" "10%-";

          # H - LEFT
          "Mod+h".action = focus-column-left;
          # J - DOWN
          "Mod+n".action = focus-workspace-down;
          # K - UP
          "Mod+e".action = focus-workspace-up;
          # L - RIGHT
          "Mod+i".action = focus-column-right;
          
          # H - LEFT
          "Mod+Shift+h".action = move-column-left;
          # J - DOWN
          "Mod+Shift+n".action = move-window-down;
          # K - UP
          "Mod+Shift+e".action = move-window-up;
          # L - RIGHT
          "Mod+Shift+i".action = move-column-right;
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
