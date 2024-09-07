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

        # Gaps
        gaps_in = 6
        gaps_out = 0

        # Radius
        rounding = 6

        # HiDPI
        monitor = highres, auto, 2

        # Input
        input * {
          type: keyboard
          xkb_layout gb
          xkb_variant colemak
        }

        # Key bindings
        bind = [
          # Open Terminal
          $mod, Return, exec, foot

          # Waybar
          exec-once = waybar

          # Search
          $mod, E, exec, wofi --show drun

          # Close Window
          $mod, Q, killactive

          # Volume Controls
          XF86AudioRaiseVolume, exec, ${pkgs.pamixer}/bin/pamixer -i 5
          XF86AudioLowerVolume, exec, ${pkgs.pamixer}/bin/pamixer -d 5
          XF86AudioMute, exec, ${pkgs.pamixer}/bin/pamixer -t
          XF86AudioMicMute, exec, ${pkgs.pamixer}/bin/pamixer --default-source -t

          # Brightness Controls
          XF86MonBrightnessUp, exec, ${pkgs.brightnessctl}/bin/brightnessctl set 1%
          XF86MonBrightnessDown, exec, ${pkgs.brightnessctl}/bin/brightnessctl set 1%-

          # Floating
          $mod, Space, togglefloating

          # Move windows
          $mod, left, movewindow, l
          $mod, right, movewindow, r
          $mod, up, movewindow, u
          $mod, down, movewindow, d

          # Workspace Navigation
          $mod, 1, workspace 1
          $mod, 2, workspace 2
          $mod, 3, workspace 3
          $mod, 4, workspace 4
          $mod, 5, workspace 5
          $mod, 6, workspace 6
          $mod, 7, workspace 7
          $mod, 8, workspace 8
          $mod, 9, workspace 9
          $mod, 0, workspace 10

          # Workspace Manipulation
          $mod SHIFT, 1, movecontainer to workspace 1
          $mod SHIFT, 2, movecontainer to workspace 2
          $mod SHIFT, 3, movecontainer to workspace 3
          $mod SHIFT, 4, movecontainer to workspace 4
          $mod SHIFT, 5, movecontainer to workspace 5
          $mod SHIFT, 6, movecontainer to workspace 6
          $mod SHIFT, 7, movecontainer to workspace 7
          $mod SHIFT, 8, movecontainer to workspace 8
          $mod SHIFT, 9, movecontainer to workspace 9
          $mod SHIFT, 0, movecontainer to workspace 10
        ]

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
