{
  lib,
  config,
  pkgs,
  inputs,
  ...
}: {
  options.modules.hyprland.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.hyprland.enable {
    home.packages = with pkgs; [
      wbg
      brightnessctl
      pamixer
      wlr-randr
    ];

    wayland.windowManager.hyprland = {
      enable = true;
      xwayland.enable = false;
      package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
      portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
      plugins = [
        #pkgs.hyprlandPlugins.borders-plus-plus
      ];

      settings = {
        monitor = [
          "eDP-1,highrr,auto,2"
        ];

        general = {
          # Master/Stack
          layout = "master";

          gaps_in = 2;
          gaps_out = 4;
          border_size = 2;

          "col.active_border" = "rgba(cba6f7ff)";
          "col.inactive_border" = "rgba(cba6f744)";

          resize_on_border = false;
          allow_tearing = true;
        };

        master = {
          mfact = 0.60;
          orientation = "left";
          inherit_fullscreen = true;
        };
  /*
        decoration = {
          rounding = 4;

          active_opacity = 1;
          inactive_opacity = 1;

          # Disabled for performance.
          blur = {
            enabled = false;
          };
          shadow = {
            enabled = false;
          };
        };
*/
        decoration = {
          # fancy corners
          rounding = 4;

          # blur
          blur = {
            enabled = true;
            size = 5;
            passes = 3;
            ignore_opacity = true;
            new_optimizations = 1;
            xray = true;
            contrast = 0.7;
            brightness = 0.8;
            vibrancy = 0.2;
            special = true; # expensive, but helps distinguish special workspaces
          };

          # shadow config
          drop_shadow = "yes";
          shadow_range = 10;
          shadow_render_power = 3;
          "col.shadow" = "rgba(292c3cee)";
        };

        # blatantly stolen from raf my beloved
        animations = {
          enabled = true;
          first_launch_animation = true;

          bezier = [
            "smoothOut, 0.36, 0, 0.66, -0.56"
            "smoothIn, 0.25, 1, 0.5, 1"
            "overshot, 0.4,0.8,0.2,1.2"
          ];

          animation = [
            "windows, 1, 4, overshot, slide"
            "windowsOut, 1, 4, smoothOut, slide"
            "border,1,10,default"

            "fade, 1, 10, smoothIn"
            "fadeDim, 1, 10, smoothIn"
            "workspaces,1,4,overshot,slidevert"
          ];
        };

/*
        animations = {
          enabled = false;
          bezier = [
            "easeOutCirc, 0, 0.55, 0.45, 1"
          ];
          animation = [
            "windowsIn, 0, 0.25, easeOutCirc"
            "windowsMove, 0, 0.25, easeOutCirc"
            "windowsOut, 0, 0.25, easeOutCirc"

            "fadeIn, 0, 0.25, easeOutCirc"

            "workspaces, 0, 2, easeOutCirc, slide"
          ];
        };*/

        input = {
          # Mouse/Pointer
          follow_mouse = 0;
          mouse_refocus = false;

          # Keyboard
          kb_layout = "gb";
          kb_variant = "colemak";
          kb_options = "ctrl:nocaps";

          # Touchpad
          touchpad = {
            tap-to-click = false;
            scroll_factor = 0.5;
            natural_scroll = true;
            clickfinger_behavior = true;
            middle_button_emulation = true;
            disable_while_typing = true;
          };
        };

        cursor = {
          no_warps = true;
        };

        render = {
          # Direct scanout attempts to reduce lag when
          # there is only one fullscreen application on a screen.
          direct_scanout = 1;
        };

        misc = {
          disable_splash_rendering = true;
          disable_hyprland_logo = true;
          vfr = true;
          vrr = 0;
        };

        # Smart Gaps
        workspace = [
          "w[tv1], gapsout:4, gapsin:0"
          "f[1], gapsout:4, gapsin:0"
        ];
        windowrulev2 = [
          # Force tearing for any window that is fullscreen.
          "immediate, fullscreen:1"
          # Disable rounded corners on waybar.
          "rounding 0, class:^(.waybar-wrapped)$"
        ];
        layerrule = [
          # Disable tofi animation.
          "noanim,(?i).*tofi.*"
        ];

        bind = [
          # Core
          "SUPER, Return, exec, foot"
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

          # Quit
          "SUPER SHIFT, Q, exit"
        ];

        # Will repeat when held.
        binde = [
          # Volume
          ",XF86AudioRaiseVolume, exec, ${pkgs.pamixer}/bin/pamixer -i 2"
          ",XF86AudioLowerVolume, exec, ${pkgs.pamixer}/bin/pamixer -d 2"
          ",XF86AudioMute, exec, ${pkgs.pamixer}/bin/pamixer -t"
          ",XF86AudioMicMute, exec, ${pkgs.pamixer}/bin/pamixer --default-source -t"

          # Brightness
          ",XF86MonBrightnessUp, exec, ${pkgs.brightnessctl}/bin/brightnessctl set 1%+"
          ",XF86MonBrightnessDown, exec, ${pkgs.brightnessctl}/bin/brightnessctl set 1%-"

          # Backlight
          "SUPER, XF86MonBrightnessUp, exec, ${pkgs.brightnessctl}/bin/brightnessctl --class leds --device kbd_backlight set 5%+"
          "SUPER, XF86MonBrightnessDown, exec, ${pkgs.brightnessctl}/bin/brightnessctl --class leds --device kbd_backlight set 5%-"

          # Hyprsunset (Capped at 6500K)
          "CTRL, XF86MonBrightnessUp, exec, temp=$(hyprctl hyprsunset temperature); [ $temp -le 6000 ] && hyprctl hyprsunset temperature $((temp + 500)); sleep 0.5; pkill -RTMIN+1 waybar"
          "CTRL, XF86MonBrightnessDown, exec, temp=$(hyprctl hyprsunset temperature); hyprctl hyprsunset temperature $((temp - 500)); sleep 0.5; pkill -RTMIN+1 waybar"
        ];

        bindl = [
          # Lock the screen with hyprlock when the lid is closed.
          #",switch:on:Apple SMC power/lid events,exec,hyprlock --immediate"
        ];

        bindm = [
          "SUPER, mouse:273, resizewindow"
          "SUPER, mouse:272, movewindow"
        ];

        exec-once = [
          # Launch hyprlock after hyprland starts and terminate the session if hyprlock
          # fails to launch. This does not consider the possibility of exec-once not
          # working - but then again I'm using autologin so there's no security here anyway.
          #"hyprlock -q --no-fade-in || loginctl terminate-session $XDG_SESSION_ID"
          # "kaneru"
          "waybar"
          # "hyprpanel"
          "${pkgs.wbg}/bin/wbg /home/alex/.config/wallpaper/wallpaper.png"
          "${pkgs.hyprsunset}/bin/hyprsunset -t 3500"
        ];
      };

      extraConfig = ''
        # Add extra config here...
      '';
    };
  };
}
