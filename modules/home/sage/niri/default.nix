{
  lib,
  config,
  pkgs,
  inputs,
  base16,
  ...
}: let
  scheme = base16 "mountain";
in {
  options.modules.niri.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.niri.enable {
    programs.niri = {
      enable = true;
      package = inputs.niri.packages.${pkgs.system}.niri-unstable;
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
            dwt = true;
          };
          focus-follows-mouse = {
            enable = false;
          };
        };

        gestures = {
          hot-corners.enable = false;
        };

        outputs = {
          "eDP-1" = {
            mode = {
              width = 2560;
              height = 1440;
              refresh = 180;
            };
            scale = 2.0;
          };
        };

        window-rules = [
          {
            clip-to-geometry = true;

            open-maximized = false;

            min-width = 2480;
            max-width = 2480;

            focus-ring = {
              enable = true;
              width = 1;
              active.color = "#${scheme.base0E}";
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

        binds = with config.lib.niri.actions; {
          "Mod+Return".action = spawn "kitty";

          "Mod+e".action = spawn "bash" "-c" "tofi-run | xargs niri msg action spawn --";

          "Mod+q".action = close-window;
          "Mod+Shift+f".action = toggle-window-floating;
          "Mod+f".action = fullscreen-window;
          "Mod+o".action = toggle-overview;

          "XF86AudioRaiseVolume".action = spawn "${pkgs.pamixer}/bin/pamixer" "-i" "2";
          "XF86AudioLowerVolume".action = spawn "${pkgs.pamixer}/bin/pamixer" "-d" "2";
          "XF86AudioMute".action = spawn "${pkgs.pamixer}/bin/pamixer" "-t";
          "XF86AudioMicMute".action = spawn "${pkgs.pamixer}/bin/pamixer" "--default-source" "-t";

          "XF86MonBrightnessUp".action = spawn "${pkgs.brightnessctl}/bin/brightnessctl" "s" "1%+";
          "XF86MonBrightnessDown".action = spawn "${pkgs.brightnessctl}/bin/brightnessctl" "s" "1%-";

          "Mod+XF86MonBrightnessUp".action = spawn "${pkgs.brightnessctl}/bin/brightnessctl" "--class" "leds" "--device" "kbd_backlight" "set" "10%+";
          "Mod+XF86MonBrightnessDown".action = spawn "${pkgs.brightnessctl}/bin/brightnessctl" "--class" "leds" "--device" "kbd_backlight" "set" "10%-";

          # Navigate
          "Mod+h".action = focus-column-left;
          "Mod+l".action = focus-column-right;
          "Mod+j".action = focus-workspace-down;
          "Mod+k".action = focus-workspace-up;

          # Move
          "Mod+Shift+h".action = move-column-left;
          "Mod+Shift+l".action = move-column-right;
          "Mod+Shift+j".action = move-column-to-workspace-down;
          "Mod+Shift+k".action = move-column-to-workspace-up;
        };

        switch-events = {
          lid-close.action.spawn = ["hyprlock" "--immediate"];
        };

        spawn-at-startup = [
          {command = ["hyprlock" "-q" "||" "loginctl" "terminate-session" "$XDG_SESSION_ID"];}
          {command = ["fish" "-c" "'waybar'"];}
          {command = ["${pkgs.wbg}/bin/wbg" "-s" "/home/alex/.config/wallpaper/wallpaper.png"];}
        ];
      };
    };
  };
}