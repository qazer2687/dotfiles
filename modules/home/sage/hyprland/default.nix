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
  options.modules.hyprland.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.hyprland.enable {
    home.packages = with pkgs; [
      wbg
      brightnessctl
      pamixer
      wlr-randr
      mpvpaper
      obs-cmd
    ];

    wayland.windowManager.hyprland = {
      enable = true;
      xwayland.enable = true;
      package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
      portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;

      settings = {
        monitor = [
          "DP-3, highres, auto, 1"
        ];

        xwayland = {
          force_zero_scaling = true;
        };

        general = {
          # Master/Stack
          layout = "master";

          gaps_in = 1;
          gaps_out = 2;
          border_size = 0;

          # base05 = text, base0E = mauve
          "col.active_border" = "rgba(${scheme.base00}ff)";
          "col.inactive_border" = "rgba(${scheme.base00}ff)";

          resize_on_border = true;
          allow_tearing = true;
        };

        master = {
          mfact = 0.65;
          orientation = "left";
        };

        animations = {
          enabled = true;

          bezier = [
            "snap, 0.2, 0, 0, 1"
          ];

          animation = [
            # Disable top level animations which children will inherit.
            "windows, 0"
            "layers, 0"
            "fade, 0"
            "border, 0"
            "borderangle, 0"
            "zoomFactor, 0"
            #"monitorAdded, 0"

            "workspaces, 1, 2, snap, slide"
          ];
        };

        input = {
          # Mouse/Pointer
          follow_mouse = 0;
          mouse_refocus = false;

          # Keyboard
          kb_layout = "gb";
          kb_variant = "colemak";
          kb_options = "ctrl:nocaps";
        };

        cursor = {
          no_warps = true;
          no_hardware_cursors = true;
          inactive_timeout = 5;
          hide_on_key_press = true;
        };

        # Required for enabling tearing.
        windowrule = [
          "match:class .*, immediate on"
          # Gamescope windows cannot handle immediate mode, but you can use the --immediate flag in gamescope command.
          #"match:class ^(gamescope)$, immediate off"
        ];

        render = {
          # Direct scanout attempts to reduce lag when
          # there is only one fullscreen application on a screen.
          direct_scanout = 1;
          new_render_scheduling = true;
        };

        misc = {
          disable_splash_rendering = true;
          disable_hyprland_logo = true;
          vrr = 0;
          # Stop "application not responding" popup on minecraft.
          enable_anr_dialog = false;
        };

        bind = [
          # Core
          "SUPER, Return, exec, kitty"
          "SUPER, E, exec, tofi-run | sh"
          "SUPER, Q, killactive"
          "SUPER, F, fullscreen"

          # Workspace Navigation
          "SUPER, 1, workspace, 1"
          "SUPER, 2, workspace, 2"
          "SUPER, 3, workspace, 3"
          "SUPER, 4, workspace, 4"
          "SUPER, 5, workspace, 5"
          "SUPER, 6, workspace, 6"
          "SUPER, 7, workspace, 7"
          "SUPER, 8, workspace, 8"
          "SUPER, 9, workspace, 9"
          "SUPER, 0, workspace, 10"

          # Workspace Manipulation
          "SUPER SHIFT, 1, movetoworkspace, 1"
          "SUPER SHIFT, 2, movetoworkspace, 2"
          "SUPER SHIFT, 3, movetoworkspace, 3"
          "SUPER SHIFT, 4, movetoworkspace, 4"
          "SUPER SHIFT, 5, movetoworkspace, 5"
          "SUPER SHIFT, 6, movetoworkspace, 6"
          "SUPER SHIFT, 7, movetoworkspace, 7"
          "SUPER SHIFT, 8, movetoworkspace, 8"
          "SUPER SHIFT, 9, movetoworkspace, 9"
          "SUPER SHIFT, 0, movetoworkspace, 10"

          # Window Navigation
          "SUPER, left, cyclenext, prev"
          "SUPER, right, cyclenext"
          "SUPER, up, cyclenext, prev"
          "SUPER, down, cyclenext"
          "SUPER, space, layoutmsg, swapwithmaster"

          # Window Manipulation
          "SUPER SHIFT, left, layoutmsg, mfact -0.05"
          "SUPER SHIFT, right, layoutmsg, mfact +0.05"

          "SUPER SHIFT, F, togglefloating"

          # Quit
          "SUPER SHIFT, Q, exit"
          
          # OBS Replay
          "$mod, BACKSPACE, exec, obs-cmd --websocket obsws://localhost:4455 replay save"

          ", SUPER_L, exec, pkill -SIGUSR1 waybar"
        ];

        bindrt = [
          "SUPER, SUPER_L, exec, pkill -SIGUSR1 waybar"
        ];

        bindm = [
          "SUPER, mouse:273, resizewindow"
          "SUPER, mouse:272, movewindow"
        ];

        exec-once = [
          "hyprlock -q || loginctl terminate-session $XDG_SESSION_ID"
          "pamixer --set-volume 50"
          "waybar"
          #"${pkgs.wbg}/bin/wbg -s /home/alex/.config/wallpaper/wallpaper.png"
          ''mpvpaper -o "--loop-file=inf" DP-3 /home/alex/.config/wallpaper/wallpaper.mkv''
          #"${pkgs.hyprsunset}/bin/hyprsunset -t 3000"
          "vesktop --start-minimized"
        ];
      };

      extraConfig = ''
        # Add extra config here...
        env = AQ_NO_ATOMIC,1
      '';
    };
  };
}
