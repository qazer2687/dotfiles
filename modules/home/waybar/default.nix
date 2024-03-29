{
  pkgs,
  lib,
  config,
  ...
}: {
  options.modules.waybar.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.waybar.enable {
    # Dependencies
    home.packages = with pkgs; [
      playerctl
    ];

    wayland.windowManager.sway.config.bars = [
      {
        command = "${pkgs.waybar}/bin/waybar";
      }
    ];

    # Config
    programs.waybar = {
      enable = true;
      settings = [
        {
          height = 40;
          layer = "top";
          modules-left = [ "clock" "sway/workspaces" "mpris"];
          modules-center = [];
          modules-right = [ "pulseaudio" "network" "battery"];
          
          # Pulseaudio
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

          # Clock
          clock = {
            format-alt = "{:%Y/%m/%d | %H:%M:%S}";
          };

          # Battery
          battery = {
            format = "{icon}";
            format-icons = ["󰂎" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
            full-at = 95;
            format-full = "󱟢";
            format-charging = "󰂄";
            tooltip = true;
            format-tooltip = "{capacity}%";

            states = {
              critical = 25;
            };
            interval = 2;
          };
          
          # Workspaces
          "sway/workspaces" = {
            format = "{icon}";
            format-icons = {
              "1" = "1";
              "2" = "2";
              "3" = "3";
              "4" = "4";
              "5" = "5";
              "6" = "6";
              "7" = "7";
              "8" = "8";
              "9" = "9";
              "0" = "10";
              urgent = "󰀧";
            };
            sort-by-number = true;
          };

          # Mpris
          mpris = {
            format = "{player_icon} {artist} - {title}";
            format-paused = "{status_icon} {artist} - {title}";
            player-icons = {
              default = "󰐊";
            };
            status-icons = {
              paused = "󰏤";
            };
          };

          # Network
          network = {
            tooltip = false;
            format-wifi = ""; # 󱐋 {frequency}
            format-disconnected = "";
            format-alt = "{ipaddr}";
            format-ethernet = "󰈁";
            interval = 2;
          };

          # CPU
          cpu = {
            tooltip = false;
            format = " {}%";
            interval = 2;
          };

          # Memory
          memory = {
            tooltip = false;
            format = "󰘚 {}%";
            interval = 2;
          };

          # Temperature
          temperature = {
            tooltip = false;
            thermal-zone = 5; # x86_pkg_temp
            critical-threshold = 70;
            format = " {temperatureC}°C";
            format-critical = " {temperatureC}°C";
            interval = 10;
          };

          # Disk
          disk = {
            tooltip = false;
            format = "󰋊 {percentage_used}%";
            interval = 240;
          };
        }
      ];

      style = ''
        * {
          border: none;
          border-radius: 0;
          font-family: FiraCode Nerd Font;
          font-size: 14px;
        }

        window#waybar {
          background-color: #000000;
        }

        #workspaces {
          background-color: transparent;
        }

        #workspaces button {
          all: initial; /* Remove GTK theme values (waybar #1351) */
          min-width: 0; /* Fix weird spacing in materia (waybar #450) */
          padding: 6px 18px;
          margin: 6px 3px;
          border-radius: 5px;
          background-color: #262626;
          color: #ffffff;
        }

        #workspaces button.active {
          color: #000000;
          background-color: #ffffff;
        }

        #workspaces button:hover {
          box-shadow: inherit;
          text-shadow: inherit;
          color: #000000;
          background-color: #ffffff;
        }

        #workspaces button.urgent {
          background-color: #f38ba8;
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
        #mpris,
        #tray {
          border-radius: 5px;
          margin: 6px 3px;
          padding: 6px 12px;
          background-color: #050505;
          color: #ffffff;
        }

        #battery {
          background-color: #ffffff;
          color: #000000;
        }

        #battery.warning,
        #battery.critical,
        #battery.urgent {
          color: #000000;
          animation-name: blink;
          animation-duration: 0.5s;
          animation-timing-function: linear;
          animation-iteration-count: infinite;
          animation-direction: alternate;
        }

        #battery.charging {
          background-color: #1ddd1d;
          color: #000000;
        }

        #network {
          padding-right: 17px;
        }

        tooltip {
          border-radius: 8px;
          padding: 15px;
          background-color: #131822;
        }

        tooltip label {
          padding: 5px;
          background-color: #131822;
        }
      '';
    };
  };
}
