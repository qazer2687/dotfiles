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
            format = "{icon} {}%";
            format-icons = ["󰂎" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
            full-at = 95;
            format-full = "{icon}";
            format-charging = "󰂄 {}%";

            states = {
              critical = 25;
            };
            interval = 5;
          };
          
          # Workspaces
          "sway/workspaces" = {
            format = "{icon}";
            format-icons = {
              "1" = "󰎤";
              "2" = "󰎧";
              "3" = "󰎪";
              "4" = "󰎭";
              "5" = "󰎱";
              "6" = "󰎳";
              "7" = "󰎶";
              "8" = "󰎹";
              "9" = "󰎼";
              "0" = "󰽽";
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
            interval = 5;
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
          min-height: 0;
          font-family: FiraCode Nerd Font;
          font-size: 14px;
        }

        window#waybar {
          background-color: #000000;
          transition-property: background-color;
          transition-duration: 0.5s;
        }

        window#waybar.hidden {
          opacity: 0.5;
        }

        #workspaces {
          background-color: transparent;
        }

        #workspaces button {
          all: initial; /* Remove GTK theme values (waybar #1351) */
          min-width: 0; /* Fix weird spacing in materia (waybar #450) */
          box-shadow: inset 0 -3px transparent; /* Use box-shadow instead of border so the text isn't offset */
          padding: 6px 18px;
          margin: 6px 3px;
          border-radius: 4px;
          background-color: #1e1e2e;
          color: #cdd6f4;
        }

        #workspaces button.active {
          color: #1e1e2e;
          background-color: #cdd6f4;
        }

        #workspaces button:hover {
        box-shadow: inherit;
        text-shadow: inherit;
        color: #1e1e2e;
        background-color: #cdd6f4;
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
          background-color: #010101;
          color: #ffffff;
        }

        #custom-power {
          margin-right: 6px;
        }

        #custom-logo {
          padding-right: 7px;
          padding-left: 7px;
          margin-left: 5px;
          font-size: 15px;
          border-radius: 8px 0px 0px 8px;
          color: #1793d1;
        }

        #memory {
          background-color: #fab387;
        }
        #battery {
          background-color: #f38ba8;
        }
        @keyframes blink {
          to {
            background-color: #010101;
            color: #ffffff;
          }
        }

        #battery.warning,
        #battery.critical,
        #battery.urgent {
          background-color: #ff0048;
          color: #181825;
          animation-name: blink;
          animation-duration: 0.5s;
          animation-timing-function: linear;
          animation-iteration-count: infinite;
          animation-direction: alternate;
        }
        #battery.charging {
          background-color: #a6e3a1;
        }

        #backlight {
          background-color: #fab387;
        }

        #pulseaudio {
          background-color: #f9e2af;
        }

        #network {
          background-color: #94e2d5;
          padding-right: 17px;
        }

        #clock {
          font-family: JetBrainsMono Nerd Font;
          background-color: #cba6f7;
        }

        #custom-power {
          background-color: #f2cdcd;
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
