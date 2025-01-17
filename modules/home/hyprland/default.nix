{
  lib,
  config,
  pkgs,
  ...
}: {
  options.modules.hyprland.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.hyprland.enable {
    home.packages = [
      pkgs.hyprsunset
    ];

    services.hyprpaper = {
      enable = true;
      settings = {
        ipc = "off";
        splash = false;
        preload = [
          "/home/alex/.config/wallpaper/wallpaper.png"
        ];
        wallpaper = [
          "HDMI-A-1,/home/alex/.config/wallpaper/wallpaper.png"
          "eDP-1,/home/alex/.config/wallpaper/wallpaper.png"
        ];
      };
    };

    wayland.windowManager.hyprland = {
      enable = true;
      package = pkgs.hyprland;
      plugins = [
        #pkgs.hyprlandPlugins.hy3
      ];
      extraConfig = ''
        # Modifier
        $mod = MOD4

        # Apply max refresh rate to all monitors. Scale to 200%.
        monitor=,highrr,auto,2

        general { 
          #layout = hy3
          gaps_in = 3
          gaps_out = 6
          border_size = 1
          resize_on_border = true 
          allow_tearing = false
        }

        decoration {
          rounding = 6
        #  active_opacity = 0.92
        #  inactive_opacity = 0.92

        #  blur {
        #    enabled = true
        #    ignore_opacity = true
        #    size = 5
        #    passes = 5
        #    vibrancy = 0.4
        #  }
        }

        animations {
          enabled = true
          # easeInOutExpo
          bezier = myBezier, 0.87, 0, 0.13, 1
          animation = windows, 0, 4, myBezier
          animation = windowsOut, 0, 4, myBezier
          animation = border, 0, 4, myBezier
          animation = borderangle, 0, 4, myBezier
          animation = fade, 0, 4, myBezier
          animation = workspaces, 1, 4, myBezier
        }

        # https://wiki.hyprland.org/Configuring/Variables/#input
        input {
          kb_layout = gb
          kb_variant = colemak
          touchpad {
            natural_scroll = true
            clickfinger_behavior = true
            middle_button_emulation = true
            disable_while_typing = true
          }
        }

        misc {
          disable_splash_rendering = true
          disable_hyprland_logo = true  
        }

        # Open Terminal
        bind = $mod, Return, exec, foot

        # Waybar
        exec-once = waybar

        # Search
        bind = $mod, E, exec, wofi --show drun

        # Close Window
        bind = $mod, Q, killactive

        # Volume Controls
        bindel = ,XF86AudioRaiseVolume, exec, ${pkgs.pamixer}/bin/pamixer -i 5
        bindel = ,XF86AudioLowerVolume, exec, ${pkgs.pamixer}/bin/pamixer -d 5
        bindel = ,XF86AudioMute, exec, ${pkgs.pamixer}/bin/pamixer -t
        bindel = ,XF86AudioMicMute, exec, ${pkgs.pamixer}/bin/pamixer --default-source -t

        # Brightness Controls
        bindel = ,XF86MonBrightnessUp, exec, ${pkgs.brightnessctl}/bin/brightnessctl set 1%+
        bindel = ,XF86MonBrightnessDown, exec, ${pkgs.brightnessctl}/bin/brightnessctl set 1%-

        # Keyboard Backlight Controls
        bindel = $mod ,XF86MonBrightnessUp, exec, ${pkgs.brightnessctl}/bin/brightnessctl --class leds --device kbd_backlight set 10%+
        bindel = $mod, XF86MonBrightnessDown, exec, ${pkgs.brightnessctl}/bin/brightnessctl --class leds --device kbd_backlight set 10%-


        # Floating
        bind = $mod, SPACE, togglefloating,

        # Move
        bind = $mod, left, movewindow, l
        bind = $mod, right, movewindow, r
        bind = $mod, up, movewindow, u
        bind = $mod, down, movewindow, d

        # Resize windows
       # bind = $mod, Shift, left, resizeactive -5 0
       # bind = $mod, Shift, up, resizeactive 0 -5
       # bind = $mod, Shift, down, resizeactive 0 5
       # bind = $mod, Shift, right, resizeactive 5 0

        # Workspace Navigation
        bind = $mod, 1, workspace, 1
        bind = $mod, 2, workspace, 2
        bind = $mod, 3, workspace, 3
        bind = $mod, 4, workspace, 4
        bind = $mod, 5, workspace, 5
        bind = $mod, 6, workspace, 6
        bind = $mod, 7, workspace, 7
        bind = $mod, 8, workspace, 8
        bind = $mod, 9, workspace, 9
        bind = $mod, 0, workspace, 10

        # Workspace Manipulation
        bind = $mod SHIFT, 1, movetoworkspace, 1
        bind = $mod SHIFT, 2, movetoworkspace, 2
        bind = $mod SHIFT, 3, movetoworkspace, 3
        bind = $mod SHIFT, 4, movetoworkspace, 4
        bind = $mod SHIFT, 5, movetoworkspace, 5
        bind = $mod SHIFT, 6, movetoworkspace, 6
        bind = $mod SHIFT, 7, movetoworkspace, 7
        bind = $mod SHIFT, 8, movetoworkspace, 8
        bind = $mod SHIFT, 9, movetoworkspace, 9
        bind = $mod SHIFT, 0, movetoworkspace, 10

        # Eye Comfort
        exec = hyprsunset -t 3000
      '';
    };
  };
}
