{
  lib,
  config,
  pkgs,
  inputs,
  ...
}: let
  screenshot = pkgs.writeShellApplication {
    name = "screenshot";
    runtimeInputs = with pkgs; [
      grim
      slurp
      wl-clipboard
    ];
    text = ''
      grim -g "$(slurp -b 00000055 -c ffffffff)" - | wl-copy -t image/png
    '';
  };
in {
  options.modules.hyprland.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.hyprland.enable {
    home.packages = with pkgs; [
      screenshot
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
      #package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
      #portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
      plugins = [
        pkgs.hyprlandPlugins.hyprscroller
        #pkgs.hyprlandPlugins.borders-plus-plus
      ];

      settings = {
        monitor = [",highrr,auto,2"];

        general = {
          # Hyprscroller
          layout = "scroller";

          gaps_in = 2;
          gaps_out = "4,30,4,30";
          border_size = 1;

          resize_on_border = false;
          allow_tearing = false;
        };

        plugin = {
          scroller = {
            column_default_width = "one";
            center_row_if_space_available = true;
          };

          /*
          borders-plus-plus = {
          	add_borders = 1;
          	col.border_1 = "#000000";
          	border_size_1 = 2;
          		};
          */
        };

        gestures = {
          # Breaks hyprscroller, needs to be disabled.
          workspace_swipe = false;
        };

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

        animations = {
          enabled = true;
          bezier = "b, 0.87, 0, 0.13, 1";
          animation = [
            "windowsIn, 0, 1, b"
            "windowsMove, 1, 1, b"
            "windowsOut, 1, 2, b"

            "fadeIn, 1, 1, b"

            "workspaces, 1, 3, b, slidevert"
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

        misc = {
          disable_splash_rendering = true;
          disable_hyprland_logo = true;
          vfr = true;
        };

        # Smart Gaps
        workspace = [
          "w[tv1], gapsout:4, gapsin:0"
          "f[1], gapsout:4, gapsin:0"
        ];
        windowrulev2 = [
          "bordersize 1, floating:0, onworkspace:w[tv1]"
          "rounding 4, floating:0, onworkspace:w[tv1]"
          "bordersize 1, floating:0, onworkspace:f[1]"
          "rounding 4, floating:0, onworkspace:f[1]"
        ];

        bind = [
          # Core
          "SUPER, Return, exec, foot"
          "SUPER, E, exec, wofi --show drun -H 20%"
          "SUPER, Q, killactive"
          "SUPER, SPACE, togglefloating"
          "SUPER, F, fullscreen"

          # Window Management
          "SUPER, left, movewindow, l"
          "SUPER, right, movewindow, r"
          "SUPER, up, movewindow, u"
          "SUPER, down, movewindow, d"

          # Workspaces
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

          # Window Resize
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
          "SUPER, XF86MonBrightnessUp, exec, ${pkgs.brightnessctl}/bin/brightnessctl --class leds --device kbd_backlight set 10%+"
          "SUPER, XF86MonBrightnessDown, exec, ${pkgs.brightnessctl}/bin/brightnessctl --class leds --device kbd_backlight set 10%-"
        ];

        bindl = [
          # Lock the screen with hyprlock when the lid is closed.
          ",switch:on:Apple SMC power/lid events,exec,hyprlock --immediate"
        ];

        bindm = [
          "SUPER, mouse:273, resizewindow"
          "SUPER, mouse:272, movewindow"
        ];

        exec-once = [
          # Launch hyprlock after hyprland starts and terminate the session if hyprlock
          # fails to launch. This does not consider the possibility of exec-once not
          # working - but then again I'm using autologin so there's no security here anyway.
          "hyprlock -q --no-fade-in || loginctl terminate-session $XDG_SESSION_ID"
          "waybar"
          # "hyprpanel"
          "${pkgs.hyprsunset}/bin/hyprsunset -t 2500"
        ];
      };

      extraConfig = ''
        # Add extra config here...
      '';
    };
  };
}
