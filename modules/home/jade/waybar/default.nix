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
      settings = [
        {
          layer = "top";
          #output = "DP-1";
          margin = "0 0 0 0";
          modules-left = ["clock" "hyprland/workspaces"];
          modules-center = [];
          modules-right = ["mpris" "memory" "pulseaudio" "disk" "network"];

          pulseaudio = {
            tooltip = false;
            scroll-step = 1;
            on-click = "pamixer -t";
            format = "{icon}";
            format-muted = "󰝟";
            format-icons = {
              default = ["󰕿" "󰖀" "󰕾"];
            };
          };

          clock = {
            format = "{:%A %d, %H:%M}";
            tooltip = false;
          };

          battery = {
            format = "{icon}";
            format-icons = ["󰂎" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
            full-at = 95;
            format-full = "󱟢";
            format-charging = "󰂄";
            tooltip = true;
            tooltip-format = "{capacity}%";
            states = {
              critical = 25;
            };
            interval = 2;
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

          mpris = {
            tooltip = false;
            format = "{player_icon} {artist} - {title}";
            format-paused = "{status_icon} {artist} - {title}";
            player-icons = {
              default = "󰐊";
            };
            status-icons = {
              paused = "󰏤";
            };
          };

          network = {
            tooltip = false;
            format-wifi = "";
            format-disconnected = "";
            format-alt = "{ipaddr}";
            format-ethernet = "󰈁";
            interval = 2;
          };

          memory = {
            tooltip = true;
            format = "󰘚";
            tooltip-format = "{percentage}%";
            interval = 2;
          };

          backlight = {
            device = "intel_backlight";
            tooltip = true;
            format = "{icon}";
            tooltip-format = "{percent}%";
            format-icons = ["󰃞" "󰃟" "󰃠"];
          };

          temperature = {
            tooltip = false;
            thermal-zone = 5;
            critical-threshold = 70;
            format = " {temperatureC}°C";
            format-critical = " {temperatureC}°C";
            interval = 10;
          };

          disk = {
            tooltip = true;
            format = "󰋊";
            tooltip-format = "{percentage_used}%";
            interval = 5;
          };
        }
      ];

      style = ''
        * {
          font-family: "Departure Mono", "FiraCode Mono Nerd Font";
          font-size: 14px;
          background-color: transparent;
          border-radius: 0px;
          margin-left: 2px;
          margin-right: 2px;
        }

        window#waybar {
          background-color: #282828;
        }

        #workspaces {
          background-color: transparent;
        }

        #workspaces button {
          padding: 3px 18px;
          margin-top: 6px;
          margin-bottom: 6px;
          margin-left: 3px;
          margin-right: 3px;
          border-radius: 5px;
          background-color: #3c3836;
          color: #ebdbb2;
        }

        #workspaces button.active {
          color: #282828;
          background-color: #d79921;
        }

        #memory,
        #custom-power,
        #battery,
        #backlight,
        #pulseaudio,
        #network,
        #clock,
        #cpu,
        #memory,
        #temperature,
        #disk,
        #tray {
          border-radius: 5px;
          margin-top: 6px;
          margin-bottom: 6px;
          margin-left: 3px;
          margin-right: 3px;
          padding: 6px 12px;
          color: #ebdbb2;
          background-color: #3c3836;
        }

        #mpris {
          padding: 3px 18px;
          margin-top: 6px;
          margin-bottom: 6px;
          margin-left: 3px;
          margin-right: 3px;
          border-radius: 5px;
          color: #282828;
          background-color: #458588;
        }

        #battery {
          background-color: #98971a;
          color: #282828;
        }

        #battery.warning,
        #battery.critical,
        #battery.urgent {
          background-color: #cc241d;
          color: #ebdbb2;
          animation-name: blink;
          animation-duration: 0.5s;
          animation-timing-function: linear;
          animation-iteration-count: infinite;
          animation-direction: alternate;
        }

        #battery.charging {
          background-color: #98971a;
          color: #282828;
        }
        
        #clock {
          margin-right: 0;
        }

        #network {
          padding-right: 17px;
        }

        tooltip {
          border-radius: 8px;
          padding: 15px;
          background-color: #1d2021;
        }

        tooltip label {
          padding: 5px;
          background-color: #1d2021;
        }
      '';
    };
  };
}