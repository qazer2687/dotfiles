{
  lib,
  config,
  pkgs,
  ...
}: let
  modifier = "Mod4";

  status = pkgs.writeShellApplication {
    name = "sway-status";
    runtimeInputs = with pkgs; [
      wireplumber
      networkmanager
      procps
      coreutils
      gawk
    ];
    text = builtins.readFile ./status.sh;
  };
in {
  options.modules.sway.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.sway.enable {
    home.packages = with pkgs; [
      grim
      slurp
      wl-clipboard
      wlsunset
      wbg
      tofi
      brightnessctl
      libnotify
      wtype
    ];

    wayland.windowManager.sway = {
      enable = true;
      package = pkgs.sway;
      checkConfig = false;
      config = {
        inherit modifier;

        menu = "tofi-run | xargs swaymsg exec --";
        terminal = "foot";

        startup = [
          {
            command = "${pkgs.hyprlock}/bin/hyprlock -q || loginctl terminate-session $XDG_SESSION_ID";
            always = true;
          }
          {
            command = "${pkgs.wlsunset}/bin/wlsunset -t 3000 -T 4000 -l 51.509865 -L -0.118092";
            always = true;
          }
          {
            command = "${pkgs.wbg}/bin/wbg ~/.config/wallpaper/wallpaper.png";
            always = true;
          }
        ];

        input = {
          "type:touchpad" = {
            dwt = "enabled";
            tap = "disabled";
            natural_scroll = "enabled";
            middle_emulation = "enabled";
          };
          "type:keyboard" = {
            xkb_layout = "gb";
            xkb_variant = "colemak";
          };
        };

        window = {
          border = 0;
          titlebar = false;
        };

        floating = {
          modifier = "Mod4";
          border = 1;
          titlebar = false;
        };

        colors = {
          focused = {
            border = "#aaaaaa";
            background = "#000000";
            text = "#000000";
            indicator = "#000000";
            childBorder = "#aaaaaa";
          };
          unfocused = {
            border = "#000000";
            background = "#000000";
            text = "#000000";
            indicator = "#000000";
            childBorder = "#000000";
          };
        };

        bars = [
          {
            position = "bottom";
            fonts = {
              names = ["Terminus"];
              style = "Bold";
              size = 14.0;
            };
            colors = {
              background = "#000000";
              statusline = "#aaaaaa";
              inactiveWorkspace = {
                border = "#000000";
                background = "#000000";
                text = "#aaaaaa";
              };
              activeWorkspace = {
                border = "#000000";
                background = "#000000";
                text = "#000000";
              };
              focusedWorkspace = {
                border = "#000000";
                background = "#aaaaaa";
                text = "#000000";
              };
            };
            statusCommand = "${lib.getExe status}";
          }
        ];

        keybindings = lib.mkOptionDefault {
          "${modifier}+Return" = "exec foot";
          "${modifier}+q" = "kill";
          "${modifier}+e" = "exec tofi-run | xargs swaymsg exec --";
          "${modifier}+Shift+c" = "reload";
          "${modifier}+Shift+q" = "exec swaynag -t warning -m 'You pressed the exit shortcut. Do you really want to exit sway? This will end your Wayland session.' -B 'Yes, exit sway' 'swaymsg exit'";

          "${modifier}+h" = "focus left";
          "${modifier}+j" = "focus down";
          "${modifier}+k" = "focus up";
          "${modifier}+l" = "focus right";

          "${modifier}+Shift+h" = "move left";
          "${modifier}+Shift+j" = "move down";
          "${modifier}+Shift+k" = "move up";
          "${modifier}+Shift+l" = "move right";

          "${modifier}+1" = "workspace number 1";
          "${modifier}+2" = "workspace number 2";
          "${modifier}+3" = "workspace number 3";
          "${modifier}+4" = "workspace number 4";
          "${modifier}+5" = "workspace number 5";
          "${modifier}+6" = "workspace number 6";
          "${modifier}+7" = "workspace number 7";
          "${modifier}+8" = "workspace number 8";
          "${modifier}+9" = "workspace number 9";
          "${modifier}+0" = "workspace number 10";

          "${modifier}+Shift+1" = "move container to workspace number 1";
          "${modifier}+Shift+2" = "move container to workspace number 2";
          "${modifier}+Shift+3" = "move container to workspace number 3";
          "${modifier}+Shift+4" = "move container to workspace number 4";
          "${modifier}+Shift+5" = "move container to workspace number 5";
          "${modifier}+Shift+6" = "move container to workspace number 6";
          "${modifier}+Shift+7" = "move container to workspace number 7";
          "${modifier}+Shift+8" = "move container to workspace number 8";
          "${modifier}+Shift+9" = "move container to workspace number 9";
          "${modifier}+Shift+0" = "move container to workspace number 10";

          "--locked XF86AudioMute" = "exec pactl set-sink-mute @DEFAULT_SINK@ toggle";
          "--locked XF86AudioLowerVolume" = "exec pactl set-sink-volume @DEFAULT_SINK@ -5%";
          "--locked XF86AudioRaiseVolume" = "exec pactl set-sink-volume @DEFAULT_SINK@ +5%";
          "--locked XF86AudioMicMute" = "exec pactl set-source-mute @DEFAULT_SOURCE@ toggle";
          "--locked XF86MonBrightnessDown" = "exec brightnessctl set 5%-";
          "--locked XF86MonBrightnessUp" = "exec brightnessctl set 5%+";

          "Print" = "exec grim -g \"$(slurp)\" - | wl-copy";
        };
      };

      extraConfig = ''
        for_window [class="obsidian"] focus_on_window_activation focus
        include /etc/sway/config.d/*
      '';

      wrapperFeatures = {
        base = true;
        gtk = true;
      };
    };
  };
}
