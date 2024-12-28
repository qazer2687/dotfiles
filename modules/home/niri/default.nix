{
  lib,
  config,
  pkgs,
  inputs,
  ...
}: {
  options.modules.niri.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.niri.enable {
    home.packages = with pkgs; [
      inputs.swww.packages.${pkgs.system}.swww
    ];

    # I assume this is to replace the niri package.
    nixpkgs.overlays = [ inputs.niri.overlays.niri ];

    programs.niri = {
      enable = true;
      #package = pkgs.niri-unstable;
      settings = {
        input = {
          keyboard.xkb = {
            layout = "us";
            variant = "colemak";
          };
        };
        outputs."eDP-1".scale = 2.0;
        binds = with config.lib.niri.actions; {
          # Terminal
          "Mod+Return".action = spawn "foot";
          
          # Application launcher
          "Mod+e".action = spawn "wofi" "-show" "drun";
          
          # Window management
          "Mod+q".action = close-window;
          #"Mod+Space".action = toggle-float;
          
          # Volume controls
          "XF86AudioRaiseVolume".action = spawn "${pkgs.pamixer}/bin/pamixer" "-i" "5";
          "XF86AudioLowerVolume".action = spawn "${pkgs.pamixer}/bin/pamixer" "-d" "5";
          "XF86AudioMute".action = spawn "${pkgs.pamixer}/bin/pamixer" "-t";
          "XF86AudioMicMute".action = spawn "${pkgs.pamixer}/bin/pamixer" "--default-source" "-t";
          
          # Brightness controls
          "XF86MonBrightnessUp".action = spawn "${pkgs.brightnessctl}/bin/brightnessctl" "set" "1%+";
          "XF86MonBrightnessDown".action = spawn "${pkgs.brightnessctl}/bin/brightnessctl" "set" "1%-";
          
          # Keyboard backlight
          "Mod+XF86MonBrightnessUp".action = spawn "${pkgs.brightnessctl}/bin/brightnessctl" "--class" "leds" "--device" "kbd_backlight" "set" "10%+";
          "Mod+XF86MonBrightnessDown".action = spawn "${pkgs.brightnessctl}/bin/brightnessctl" "--class" "leds" "--device" "kbd_backlight" "set" "10%-";
          
          # Window movement
          "Mod+left".action = move-column-left;
          "Mod+right".action = move-column-right;
          "Mod+up".action = move-window-up;
          "Mod+down".action = move-window-down;
          
          # Workspace switching
          "Mod+1".action = focus-workspace 1;
          "Mod+2".action = focus-workspace 2;
          "Mod+3".action = focus-workspace 3;
          "Mod+4".action = focus-workspace 4;
          "Mod+5".action = focus-workspace 5;
          "Mod+6".action = focus-workspace 6;
          "Mod+7".action = focus-workspace 7;
          "Mod+8".action = focus-workspace 8;
          "Mod+9".action = focus-workspace 9;
          "Mod+0".action = focus-workspace 10;
          
          # Move windows to workspaces
          "Mod+Shift+1".action = move-window-to-workspace 1;
          "Mod+Shift+2".action = move-window-to-workspace 2;
          "Mod+Shift+3".action = move-window-to-workspace 3;
          "Mod+Shift+4".action = move-window-to-workspace 4;
          "Mod+Shift+5".action = move-window-to-workspace 5;
          "Mod+Shift+6".action = move-window-to-workspace 6;
          "Mod+Shift+7".action = move-window-to-workspace 7;
          "Mod+Shift+8".action = move-window-to-workspace 8;
          "Mod+Shift+9".action = move-window-to-workspace 9;
          "Mod+Shift+0".action = move-window-to-workspace 10;
        };

        debug = {
          # Fixes a black screen bug on Asahi.
          # https://github.com/YaLTeR/niri/wiki/Getting-Started#asahi-arm-and-other-kmsro-devices
          render-drm-device = "/dev/dri/renderD128";
        };

        spawn-at-startup = [
          # This isn't possible yet on Asahi.
          # { command = [ "gammastep" "-t" "6500:3000" ]; }
          { command = [ "swww-daemon" ]; }
          { command = [ "swww" "img" "/home/alex/.config/wallpaper/wallpaper.gif" ]; }
          { command = [ "systemctl" "--user" "reset-failed" "waybar.service" ]; }
        ];
      };
    };
  };
}