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
          layer = "top";
          margin = "6 0 0 0";
          modules-left = ["clock" "sway/workspaces"];
          modules-center = [];
          modules-right = ["pulseaudio" "battery"];

          # Pulseaudio
          pulseaudio = {
            tooltip = false;
            scroll-step = 1;
            on-click = "pamixer -t";
            format = "{icon}";
            format-muted = "󰝟 ";
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
            format = "{icon}"; # {icon}
            format-icons = [" " " " " " " " " "];
            format-charging = " ";
            tooltip = true;
            tooltip-format = "{capacity}%";
            interval = 5;
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
            };
            sort-by-number = true;
          };

          # Mpris
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

          # Network
          network = {
            tooltip = false;
            format-wifi = "{ipaddr}"; # 󱐋 {frequency}
            format-disconnected = "";
            format-alt = "{ipaddr}";
            format-ethernet = "󰈁";
            interval = 5;
          };

          # Memory
          memory = {
            tooltip = true;
            format = "󰘚";
            tooltip-format = "{percentage}%";
            interval = 2;
          };

          # Backlight
          backlight = {
            device = "intel_backlight";
            tooltip = true;
            format = "{icon}";
            tooltip-format = "{percent}%";
            format-icons = ["󰃞" "󰃟" "󰃠"];
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
            tooltip = true;
            format = "󰋊";
            tooltip-format = "{percentage_used}%";
            interval = 5;
          };
        }
      ];

      style = ''
        * {
          font-family: FiraCode Mono Nerd Font;
          font-size: 12px;
          background-color: 000000;
          border-radius: 0px;
          margin-left: 2px;
          margin-right: 2px;
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
          border-radius: 4px;
          padding: 4px 12px;
          background-color: #000000;
          color: #ffffff;
        }

        window#waybar {
          background-color: transparent;
        }

        #workspaces {
          background-color: #000000;
          border-radius: 4px;
        }

        #workspaces button {
          all: initial; /* Remove GTK theme values (waybar #1351) */
          min-width: 0; /* Fix weird spacing in materia (waybar #450) */
          padding: 4px 4px;
          border-radius: 4px;
          background-color: #000000;
          color: #606060;
        }

        #workspaces button.visible {
          color: #ffffff;
          background-color: #000000;
        }

        #battery.warning,
        #battery.critical,
        #battery.urgent {
          background-color: #cc0000;
          color: #000000;
        }

        #battery.charging {
          color: #004400;
          background-color: #000000;
        }

        #network {
          padding-right: 17px;
        }

        tooltip {
          border-radius: 4px;
          padding: 15px;
          background-color: #000000;
        }

        tooltip label {
          padding: 3px;
          background-color: #000000;
        }
      '';
    };
  };
}
