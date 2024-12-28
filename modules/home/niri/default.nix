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
          "Logo+Return".action = spawn "foot";
          
          # Application launcher
          "Logo+e".action = spawn "wofi --show drun";
          
          # Window management
          "Logo+q".action = close-window;
          #"Logo+Space".action = toggle-float;
          
          # Volume controls
          "XF86AudioRaiseVolume".action = spawn "${pkgs.pamixer}/bin/pamixer" "-i" "5";
          "XF86AudioLowerVolume".action = spawn "${pkgs.pamixer}/bin/pamixer" "-d" "5";
          "XF86AudioMute".action = spawn "${pkgs.pamixer}/bin/pamixer" "-t";
          "XF86AudioMicMute".action = spawn "${pkgs.pamixer}/bin/pamixer" "--default-source" "-t";
          
          # Brightness controls
          "XF86MonBrightnessUp".action = spawn "${pkgs.brightnessctl}/bin/brightnessctl" "set" "1%+";
          "XF86MonBrightnessDown".action = spawn "${pkgs.brightnessctl}/bin/brightnessctl" "set" "1%-";
          
          # Keyboard backlight
          "Logo+XF86MonBrightnessUp".action = spawn "${pkgs.brightnessctl}/bin/brightnessctl" "--class" "leds" "--device" "kbd_backlight" "set" "10%+";
          "Logo+XF86MonBrightnessDown".action = spawn "${pkgs.brightnessctl}/bin/brightnessctl" "--class" "leds" "--device" "kbd_backlight" "set" "10%-";
          
          # Window movement
          "Logo+left".action = move-column-left;
          "Logo+right".action = move-column-right;
          "Logo+up".action = move-window-up;
          "Logo+down".action = move-window-down;
          
          # Workspace switching
          "Logo+1".action = focus-workspace 1;
          "Logo+2".action = focus-workspace 2;
          "Logo+3".action = focus-workspace 3;
          "Logo+4".action = focus-workspace 4;
          "Logo+5".action = focus-workspace 5;
          "Logo+6".action = focus-workspace 6;
          "Logo+7".action = focus-workspace 7;
          "Logo+8".action = focus-workspace 8;
          "Logo+9".action = focus-workspace 9;
          "Logo+0".action = focus-workspace 10;
          
          # Move windows to workspaces
          "Logo+Shift+1".action = move-window-to-workspace 1;
          "Logo+Shift+2".action = move-window-to-workspace 2;
          "Logo+Shift+3".action = move-window-to-workspace 3;
          "Logo+Shift+4".action = move-window-to-workspace 4;
          "Logo+Shift+5".action = move-window-to-workspace 5;
          "Logo+Shift+6".action = move-window-to-workspace 6;
          "Logo+Shift+7".action = move-window-to-workspace 7;
          "Logo+Shift+8".action = move-window-to-workspace 8;
          "Logo+Shift+9".action = move-window-to-workspace 9;
          "Logo+Shift+0".action = move-window-to-workspace 10;
        };

        # Autostart applications
        spawn-at-startup = [
          { command = [ "waybar" ]; }
          # This isn't possible yet on Asahi.
          # { command = [ "gammastep" "-t" "6500:3000" ]; }
          { command = [ "swww-daemon" ]; }
          { command = [ "swww" "img" "/home/alex/.config/wallpaper/wallpaper.gif" ]; }
        ];
      };
    };
  };
}