{
  pkgs,
  lib,
  config,
  ...
}: let
  modifier = "Mod4";

  wayland-screenshot = pkgs.writeShellApplication {
    name = "wayland-screenshot";
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
  options.modules.sway.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.sway.enable {
    home.packages = with pkgs; [
      vlc
    ];

    wayland.windowManager.sway = {
      enable = true;
      package = pkgs.swayfx.overrideAttrs (_old: {passthru.providedSessions = ["sway"];});
      config = {
        inherit modifier;

        # Gaps
        gaps = {
          inner = 8;
          outer = 0;
        };

        # Input
        input = {
          "type:pointer" = {
            accel_profile = "flat";
            pointer_accel = "0.0";
          };
          "type:keyboard" = {
            xkb_layout = "gb";
            xkb_variant = "colemak";
          };
        };

        # Bar
        bars = lib.mkForce [];


        # Display & Wallpaper
        output = {
          "*".bg = "~/.config/wallpaper/wallpaper.png fill";
          "DP-1".mode = "1920x1080@120Hz";
        };

        # Decorations
        window = {
          titlebar = false;
          border = 0;
        };

        keybindings = lib.mkOptionDefault rec {
          # Open Terminal
          "${modifier}+Return" = "exec foot";

          # Close Window
          "${modifier}+q" = "kill";

          # Reload
          "${modifier}+Shift+r" = "reload";

          # Search
          "${modifier}+e" = ''exec ${pkgs.dmenu-wayland}/bin/dmenu-wl_run -b -i -nb "#000000" -sb "#ffffff" -nf "#ffffff" -sf "#000000" -fn "FiraCode Nerd Font"'';

          # Floating
          "${modifier}+space" = "floating toggle";

          # Screenshot
          "Print" = "exec ${lib.getExe wayland-screenshot}";

          # Volume Controls
          XF86AudioRaiseVolume = "exec ${pkgs.pamixer}/bin/pamixer -i 5";
          XF86AudioLowerVolume = " exec ${pkgs.pamixer}/bin/pamixer -d 5";
          XF86AudioMute = "exec ${pkgs.pamixer}/bin/pamixer -t";
          XF86AudioMicMute = "exec ${pkgs.pamixer}/bin/pamixer --default-source -t";

          # Brightness Controls
          XF86MonBrightnessUp = "exec ${pkgs.brightnessctl}/bin/brightnessctl set 5%+";
          XF86MonBrightnessDown = "exec ${pkgs.brightnessctl}/bin/brightnessctl set 5%-";

          # Workspace Navigation
          "${modifier}+1" = "workspace number 1";
          "${modifier}+2" = "workspace number 2";
          "${modifier}+3" = "workspace number 3";
          "${modifier}+4" = "workspace number 4";
          "${modifier}+5" = "workspace number 5";
          "${modifier}+6" = "workspace number 6";
          "${modifier}+7" = "workspace number 7";
          "${modifier}+8" = "workspace number 8";
          "${modifier}+9" = "workspace number 9";

          # Workspace Manipulation
          "${modifier}+Shift+1" = "move container to workspace number 1";
          "${modifier}+Shift+2" = "move container to workspace number 2";
          "${modifier}+Shift+3" = "move container to workspace number 3";
          "${modifier}+Shift+4" = "move container to workspace number 4";
          "${modifier}+Shift+5" = "move container to workspace number 5";
          "${modifier}+Shift+6" = "move container to workspace number 6";
          "${modifier}+Shift+7" = "move container to workspace number 7";
          "${modifier}+Shift+8" = "move container to workspace number 8";
          "${modifier}+Shift+9" = "move container to workspace number 9";
        };
      };

      extraConfig = ''
        # Corner Radius
        corner_radius 5

        # Eye Comfort (EXPERIMENTAL)
        exec nohup gammastep -xO 3500

        # Notification Daemon
        exec_always mako

        # Waybar
        bar {
          swaybar_command waybar
        }

      '';

      extraSessionCommands = ''
        export XDG_SESSION_TYPE=wayland
        export XDG_CURRENT_DESKTOP=sway
        export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
        export QT_AUTO_SCREEN_SCALE_FACTOR=0
        export QT_SCALE_FACTOR=1
        export GDK_SCALE=1
        export GDK_DPI_SCALE=1
        export MOZ_ENABLE_WAYLAND=1
      '';

      wrapperFeatures = {
        base = true;
        gtk = true;
      };
    };
  };
}
