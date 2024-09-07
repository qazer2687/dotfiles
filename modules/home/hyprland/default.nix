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
          gaps_in = 0
          gaps_out = 6
          border_size = 0
          resize_on_border = true 
          allow_tearing = false
        }

        decoration {
          rounding = 6
          active_opacity = 1.0
          inactive_opacity = 0.9
          drop_shadow = true
          shadow_range = 4
          shadow_render_power = 3
          col.shadow = rgba(1a1a1aee)
          blur {
            enabled = true
            size = 3
            passes = 1
            vibrancy = 0.1696
          }
        }

        animations {
          enabled = true
          bezier = myBezier, 0.05, 0.9, 0.1, 1.05
          animation = windows, 1, 7, myBezier
          animation = windowsOut, 1, 7, default, popin 80%
          animation = border, 1, 10, default
          animation = borderangle, 1, 8, default
          animation = fade, 1, 7, default
          animation = workspaces, 1, 6, default
        }

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
        bind = $mod, SPACE, togglefloating,

        # Move windows
        bind = $mod, left, movewindow, l
        bind = $mod, right, movewindow, r
        bind = $mod, up, movewindow, u
        bind = $mod, down, movewindow, d

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
      '';
    };
  };
}
