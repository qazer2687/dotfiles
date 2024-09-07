{
  lib,
  config,
  pkgs,
  ...
}: {
  options.modules.hyprland.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.hyprland.enable {
    wayland.windowManager.hyprland = {
      enable = true;
      extraConfig = ''
        # Modifier
        $mod = MOD4

        general { 
          gaps_in = 6
          gaps_out = 0

          border_size = 0


          # Set to true enable resizing windows by clicking and dragging on borders and gaps
          resize_on_border = true 

          # Please see https://wiki.hyprland.org/Configuring/Tearing/ before you turn this on
          allow_tearing = false

        }

        decoration {
          rounding = 6

          # Change transparency of focused and unfocused windows
          active_opacity = 1.0
          inactive_opacity = 0.9

          drop_shadow = true
          shadow_range = 4
          shadow_render_power = 3
          col.shadow = rgba(1a1a1aee)

          # https://wiki.hyprland.org/Configuring/Variables/#blur
          blur {
            enabled = true
            size = 3
            passes = 1
            
            vibrancy = 0.1696
          }
        }

        animations {
          enabled = true

          # Default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more

          bezier = myBezier, 0.05, 0.9, 0.1, 1.05

          animation = windows, 1, 7, myBezier
          animation = windowsOut, 1, 7, default, popin 80%
          animation = border, 1, 10, default
          animation = borderangle, 1, 8, default
          animation = fade, 1, 7, default
          animation = workspaces, 1, 6, default
        }

        # HiDPI
        monitor = highres, auto, 2

        # Input
        input {
          kb_layout = gb
          kb_variant = colemak
        }

        # Open Terminal
        bind = $mod, Return, exec, foot

        # Waybar
        bind = exec-once = waybar

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
        bindel = ,XF86MonBrightnessUp, exec, ${pkgs.brightnessctl}/bin/brightnessctl set 1%
        bindel = ,XF86MonBrightnessDown, exec, ${pkgs.brightnessctl}/bin/brightnessctl set 1%-

        # Floating
        bind = $mod, Space, togglefloating

        # Move windows
        bind = $mod, left, movewindow, l
        bind = $mod, right, movewindow, r
        bind = $mod, up, movewindow, u
        bind = $mod, down, movewindow, d

        # Workspace Navigation
        bind = $mod, 1, workspace 1
        bind = $mod, 2, workspace 2
        bind = $mod, 3, workspace 3
        bind = $mod, 4, workspace 4
        bind = $mod, 5, workspace 5
        bind = $mod, 6, workspace 6
        bind = $mod, 7, workspace 7
        bind = $mod, 8, workspace 8
        bind = $mod, 9, workspace 9
        bind = $mod, 0, workspace 10

        # Workspace Manipulation
        bind = $mod SHIFT, 1, movecontainer to workspace 1
        bind = $mod SHIFT, 2, movecontainer to workspace 2
        bind = $mod SHIFT, 3, movecontainer to workspace 3
        bind = $mod SHIFT, 4, movecontainer to workspace 4
        bind = $mod SHIFT, 5, movecontainer to workspace 5
        bind = $mod SHIFT, 6, movecontainer to workspace 6
        bind = $mod SHIFT, 7, movecontainer to workspace 7
        bind = $mod SHIFT, 8, movecontainer to workspace 8
        bind = $mod SHIFT, 9, movecontainer to workspace 9
        bind = $mod SHIFT, 0, movecontainer to workspace 10

        # Resize
        binde = [
          $mod SHIFT, left, resizeactive, -50 0
          $mod SHIFT, right, resizeactive, 50 0
          $mod SHIFT, up, resizeactive, 0 -50
          $mod SHIFT, down, resizeactive, 0 50
        ]
      '';
    };
  };
}
