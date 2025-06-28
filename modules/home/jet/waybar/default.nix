{
  lib,
  config,
  pkgs,
  ...
}: {
  options.modules.waybar.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.waybar.enable {
    wayland.windowManager.sway.config.bars = [
      {
        command = "${pkgs.waybar}/bin/waybar";
      }
    ];

    home.packages = with pkgs; [
      # MPRIS Dependency
      playerctl
    ];

    programs.waybar = {
      enable = true;
      settings = {
        mainBar = {
          layer = "top";
          height = 28;
          margin = "0 0 0 0";
          modules-left = [ "clock" "hyprland/workspaces" ];
          modules-center = [ ];
          modules-right = [ "tray" "backlight" "network" "pulseaudio" "battery" ];
          
          pulseaudio = {
            format = "VOL: {volume}%";
            tooltip = false;
            format-muted = "VOL: MUTED";
            format-icons = {
              default = [ " " " " " " ];
            };
          };
          
          clock = {
            format = "{:%A %d, %H:%M}";
            tooltip = false;
            margin-right = 15;
          };
          
          tray = {
            icon-size = 14;
            spacing = 10;
            reverse-direction = true;
          };
          
          battery = {
            tooltip = false;
            format = "BAT: {capacity}%";
            format-charging = "BAT: {capacity}% [CHARGING]";
            interval = 10;
            states = {
              warning = 25;
              critical = 10;
            };
            margin-left = 15;
          };
          
          "hyprland/workspaces" = {
            format = "{icon}";
            format-icons = {
              "1" = "1";
              "2" = "2";
              "3" = "3";
              "4" = "4";
              "5" = "5";
            };
          };
          
          backlight = {
            device = "apple-panel-bl";
            format = "BKL: {percent}%";
            tooltip = false;
          };
          
          network = {
            tooltip = false;
            format-wifi = "NET: {essid}";
            family = "ipv4";
            format-disconnected = "NET: OFFLINE";
            format-ethernet = "NET: WIRED";
            interval = 10;
          };
          
          mpris = {
            tooltip = false;
            format = "PLAYING: {artist} - {title}";
            format-paused = "PAUSED: {artist} - {title}";
            player-icons = {
              default = " ";
            };
            artist-len = 20;
            title-len = 20;
            status-icons = {
              paused = " ";
            };
          };
        };
      };
      
      style = ''
        @define-color rosewater #f5e0dc;
        @define-color flamingo #f2cdcd;
        @define-color pink #f5c2e7;
        @define-color mauve #cba6f7;
        @define-color red #f38ba8;
        @define-color maroon #eba0ac;
        @define-color peach #fab387;
        @define-color yellow #f9e2af;
        @define-color green #a6e3a1;
        @define-color teal #94e2d5;
        @define-color sky #89dceb;
        @define-color sapphire #74c7ec;
        @define-color blue #89b4fa;
        @define-color lavender #b4befe;
        @define-color text #cdd6f4;
        @define-color subtext1 #bac2de;
        @define-color subtext0 #a6adc8;
        @define-color overlay2 #9399b2;
        @define-color overlay1 #7f849c;
        @define-color overlay0 #6c7086;
        @define-color surface2 #585b70;
        @define-color surface1 #45475a;
        @define-color surface0 #313244;
        @define-color base #1e1e2e;
        @define-color mantle #181825;
        @define-color crust #11111b;
        
        * {
            border: none;
            border-radius: 1px;
            font-family: JetBrainsMono Nerd Font, Font Awesome;
            font-size: 13px;
            min-height: 0;
        }

        window#waybar {
            background-color: @mantle;
            color: @text;
        }

        window#waybar.hidden {
            opacity: 0.2;
        }

        tooltip {
            background-color: @base;
            border: 1px solid @surface1;
        }

        tooltip label {
            color: @text;
        }

        button {
            box-shadow: inset 0 -3px transparent;
            border: none;
            border-radius: 1;
        }

        button:hover {
            background: inherit;
            box-shadow: inset 0 -3px @text;
        }

        #workspaces button {
            padding: 0 0;
            background-color: @mantle;
            color: @text;
        }

        #workspaces button:hover {
            box-shadow: inherit;
            text-shadow: inherit;
            background-image: linear-gradient(0deg, @surface1, @mantle);
        }

        #workspaces button.focused {
            background-image: linear-gradient(0deg, @mauve, @surface1);
            box-shadow: inset 0 -3px @text;
        }

        #workspaces button.urgent {
            background-image: linear-gradient(0deg, @red, @mantle);
        }

        #taskbar button.active {
            background-image: linear-gradient(0deg, @surface1, @mantle);
        }

        #mode {
            background-color: @base;
            box-shadow: inset 0 -2px @text;
        }

        #mpris,
        #custom-weather,
        #clock,
        #language,
        #pulseaudio,
        #bluetooth,
        #network,
        #memory,
        #cpu,
        #temperature,
        #disk,
        #custom-kernel,
        #idle_inhibitor,
        #scratchpad,
        #mode,
        #tray {
            padding: 0 10px;
            margin: 5px 1px;
            color: @text;
        }

        #window,
        #workspaces {
            margin: 0 4px;
        }

        .modules-left > widget:first-child > #workspaces {
            margin-left: 0;
        }

        .modules-right > widget:last-child > #workspaces {
            margin-right: 0;
        }

        #custom-weather {
            background-color: @teal;
            color: @mantle;
            margin-right: 5px;
        }

        #custom-kernel {
            background-color: @rosewater;
            color: @mantle;
        }

        #clock {
            background-color: @green;
            color: @mantle;
        }

        @keyframes blink {
            to {
                background-color: @mantle;
                color: @text;
            }
        }

        label:focus {
            background-color: @mantle;
        }

        #cpu {
            background-color: @mauve;
            color: @mantle;
            min-width: 45px;
        }

        #memory {
            background-color: @red;
            color: @mantle;
        }

        #disk {
            background-color: @flamingo;
            color: @mantle;
        }

        #network {
            background-color: @peach;
            color: @mantle;
        }

        #network.disconnected {
            background-color: red;
            color: @mantle;
        }

        #bluetooth {
            background-color: @maroon;
            color: @mantle;
            min-width: 40px;
        }

        #pulseaudio {
            background-color: @yellow;
            color: @mantle;
        }

        #pulseaudio.muted {
            background-color: red;
            color: @mantle;
        }

        #temperature {
            background-color: @pink;
            color: @mantle;
            min-width: 37px;
        }

        #temperature.critical {
            background-color: red;
            color: @mantle;
            min-width: 37px;
        }

        #mpris {
            background-color: @base;
            color: @text;
        }

        #tray {
            background-color: @overlay0;
            color: @text;
        }

        #tray > .passive {
            -gtk-icon-effect: dim;
        }

        #tray > .needs-attention {
            -gtk-icon-effect: highlight;
            background-color: @mantle;
        }

        #idle_inhibitor {
            background-color: @base;
            color: @text;
            font-family: Inter;
        }

        #idle_inhibitor.activated {
            background-color: @text;
            color: @base;
        }

        #scratchpad {
            background-color: @base;
            color: @text;
        }

        #scratchpad.empty {
            background-color: transparent;
        }
      '';
    };
  };
}
