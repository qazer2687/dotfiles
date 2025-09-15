{
  lib,
  config,
  pkgs,
  base16,
  ...
}: let 
  scheme = base16 "mountain";
in {
  options.modules.waybar.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.waybar.enable {
    
    home.file.".config/waybar/scripts/pingServer.sh".text = builtins.readFile ./scripts/pingServer.sh;
    home.file.".config/waybar/scripts/pingServer.sh".executable = true;

    programs.waybar = {
      enable = true;
      settings = {
        mainBar = {
          layer = "top";
          height = 28;
          margin = "0 0 0 0";
          modules-left = ["hyprland/workspaces" "custom/pingServer"];
          modules-center = [];
          modules-right = ["tray" "network" "pulseaudio" "clock" "battery"];

          pulseaudio = {
            format = "VOL: {volume}%";
            tooltip = false;
            format-muted = "VOL: MUTED";
          };

          "custom/hyprsunset" = {
            exec = ''printf "TEMP: %sK" "$(hyprctl hyprsunset temperature)"'';
            signal = 1;
            format = "{}";
            tooltip = false;
          };

          "custom/pingServer" = {
            exec = "$HOME/.config/waybar/scripts/pingServer.sh";
            interval = 30;
            format = "{}";
          };

          clock = {
            format = "{:%A %d, %H:%M}";
            tooltip = false;
            margin-right = 15;
          };

          tray = {
            icon-size = 14;
            spacing = 12;
            reverse-direction = true;
          };

          battery = {
            tooltip = false;
            format = "BAT: {capacity}%";
            format-charging = "BAT: {capacity}%";
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

          "niri/workspaces" = {
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
            format = "{title}";
            format-paused = "{title}";
            artist-len = 20;
            title-len = 20;
            player-icons = {
              default = "";
            };
            status-icons = {
              paused = "";
            };
          };
        };
      };

      style = ''
        * {
          border: none;
          border-radius: 0px;
          font-family: TX02;
          font-size: 11px;
          min-height: 0;
        }

        window#waybar {
          background-color: #${scheme.base00};
        }

        #mpris, #clock, #language, #pulseaudio, #bluetooth, #network,
        #memory, #cpu, #temperature, #disk, #custom-kernel, #custom-hyprsunset, #idle_inhibitor, #mode,
        #backlight, #battery, #workspaces button, #workspaces button.focused,
        #workspaces button.active, custom-pingServer {
          padding: 0 8px;
          margin: 4px 2px;
          border-radius: 2px;
          background-color: #${scheme.base01};
          color: #${scheme.base05};
        }

        #custom-pingServer.up { color: #${scheme.base0D} }
        #custom-pingServer.down { color: #${scheme.base04} }

        #mpris {
          border: 1px solid #${scheme.base0D};
        }

        #workspaces button.active {
          background-color: #${scheme.base05};
          color: #${scheme.base00};
        }

        @keyframes blinkWarning {
          to {
            background-color: #${scheme.base09};
            color: #${scheme.base00};
          }
        }

        @keyframes blinkCritical {
          to {
            background-color: #${scheme.base08};
            color: #${scheme.base00};
          }
        }

        #battery.warning:not(.charging) {
          background-color: #${scheme.base0A};
          color: #${scheme.base00};
          animation-name: blinkWarning;
          animation-duration: 0.5s;
          animation-timing-function: linear;
          animation-iteration-count: infinite;
          animation-direction: alternate;
        }

        #battery.critical:not(.charging) {
          background-color: #${scheme.base08};
          color: #${scheme.base00};
          animation-name: blinkCritical;
          animation-duration: 0.5s;
          animation-timing-function: linear;
          animation-iteration-count: infinite;
          animation-direction: alternate;
        }

        #battery.charging {
          background-color: #${scheme.base0B};
          color: #${scheme.base00};
        }

        /* Pad Edges */

        #workspaces {
          margin-left: 16px;
        }

        #tray {
          margin-right: 4px;
        }

        #battery {
          margin-right: 16px;
        }
      '';
    };
  };
}
