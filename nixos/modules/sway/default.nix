{
  lib,
  config,
  pkgs,
  ...
}: {
  options.modules.sway.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.sway.enable {
    security.polkit.enable = true;
    programs.sway = {
      enable = true;
      wrapperFeatures.gtk = true;
      package = pkgs.swayfx.overrideAttrs (_old: {passthru.providedSessions = ["sway"];});

      extraPackages = with pkgs; [
        brightnessctl
        dmenu-wayland
        mako
        fltk
        grim
        wl-clipboard
        slurp
        wayland
        gammastep
      ];
    };

    # Waybar#1266
    xdg.portal = {
      enable = false;
    };

    environment.etc."sway/config".text = ''
      # Modifier Key
      set $mod Mod4

      # Volume Controls
      bindsym XF86AudioRaiseVolume exec --no-startup-id pamixer -i 5
      bindsym XF86AudioLowerVolume exec --no-startup-id pamixer -d 5
      bindsym XF86AudioMute exec --no-startup-id pamixer -t
      bindsym XF86AudioMicMute exec --no-startup-id pamixer --default-source -t

      # Launch Terminal
      bindsym $mod+Return exec foot

      # Toggle Floating
      bindsym $mod+space floating toggle

      # Close Window
      bindsym $mod+q kill

      # Application Launcher
      bindsym $mod+e exec dmenu-wl_run -b -i -nb "#000000" -sb "#ffffff" -nf "#ffffff" -sf "#000000" -fn "FiraCode Nerd Font"

      # Wallpaper
      output * bg /home/alex/.config/wallpaper/wallpaper.png fill

      # Notification Daemon
      exec_always --no-startup-id mako

      # System Bar
      #exec_always --no-startup-id killall .waybar-wrapped -q; waybar

      # Screenshot Binds
      bindsym Print exec grim -g "$(slurp -b 00000055 -c ffffffff)" - | wl-copy

      # Eye Comfort \\ EXPERIMENTAL
      # exec --no-startup-id nohup gammastep -xO 3500

      # Floating Resize
      floating_modifier $mod normal

      # Brightness Control
      bindsym XF86MonBrightnessUp exec --no-startup-id brightnessctl set 10%+
      bindsym XF86MonBrightnessDown exec --no-startup-id brightnessctl set 10%-

      # Workspace Navigation
      bindsym $mod+Left workspace prev
      bindsym $mod+Right workspace next
      bindsym $mod+1 workspace number 1
      bindsym $mod+2 workspace number 2
      bindsym $mod+3 workspace number 3
      bindsym $mod+4 workspace number 4
      bindsym $mod+5 workspace number 5
      bindsym $mod+6 workspace number 6
      bindsym $mod+7 workspace number 7
      bindsym $mod+8 workspace number 8
      bindsym $mod+9 workspace number 9
      bindsym $mod+0 workspace number 10

      # Container Manipulation
      bindsym $mod+Shift+1 move container to workspace number 1
      bindsym $mod+Shift+2 move container to workspace number 2
      bindsym $mod+Shift+3 move container to workspace number 3
      bindsym $mod+Shift+4 move container to workspace number 4
      bindsym $mod+Shift+5 move container to workspace number 5
      bindsym $mod+Shift+6 move container to workspace number 6
      bindsym $mod+Shift+7 move container to workspace number 7
      bindsym $mod+Shift+8 move container to workspace number 8
      bindsym $mod+Shift+9 move container to workspace number 9
      bindsym $mod+Shift+0 move container to workspace number 10

      # Restart Sway
      bindsym $mod+Shift+r exec swaymsg reload

      # Gaps
      default_border none
      gaps inner 10
      gaps outer 0

      # Keyboard Layout
      input * {
        xkb_layout "gb"
        xkb_variant "colemak"
      }
      input 3 xkb_model "pc101"

      # Hide Bar
      bar {
        #mode invisible
        swaybar_command waybar
      }

      # SwayFX
      corner_radius 5
      shadows disable
      shadow_color #0000007F
      #default_dim_inactive 0.1
      #dim_inactive_colors.unfocused #000000FF
    '';
  };
}