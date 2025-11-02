{
  lib,
  config,
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
          modules-left = ["clock" "hyprland/workspaces" "custom/pingServer"];
          modules-center = [];
          modules-right = ["tray" "network" "pulseaudio" "custom/hyprsunset" "battery"];

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
            return-type = "json";
          };

          clock = {
            format = "{:%H:%M}";
            format-alt = "{:%A %d, %H:%M}";
            tooltip = false;
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
              "6" = "6";
              "7" = "7";
              "8" = "8";
              "9" = "9";
              "0" = "0";
            };
          };

          backlight = {
            device = "apple-panel-bl";
            format = "BKL: {percent}%";
            tooltip = false;
          };

          network = {
            tooltip = false;
            format = "NET: {essid}";
            format-alt = "{essid} - {ifname} - {ipaddr}";
            format-disconnected = "NET: OFFLINE";
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
         /* background-color: rgba(15, 15, 15, 0.85)*/
           /*background: transparent;*/
          background: linear-gradient(to right, #000000 0%, #000000 50%, transparent 50%, transparent 100%);
        }

        #mpris, #clock, #language, #pulseaudio, #bluetooth, #network,
        #memory, #cpu, #temperature, #disk, #custom-kernel, #custom-hyprsunset, #idle_inhibitor, #mode,
        #backlight, #battery, #custom-pingServer, #workspaces button, #workspaces button.active, #tray {
          padding: 0 8px;
          margin: 2px 2px;
          border-radius: 4px;
        
          background-color: #${scheme.base01};
          color: #${scheme.base05};
        }

        #workspaces {
          color: transparent;
          background-color: #${scheme.base01};
          border-radius: 4px;
          margin: 2px 2px;
        }
        #workspaces button {
          background-color: transparent;
          border-radius: 4px;
          margin: 0px 0px;
        }
        #workspaces button.active {
          background-color: #${scheme.base02};
          border-radius: 4px;
          margin: 0px 0px;
          
        }

        #custom-pingServer.up {
          color: #${scheme.base0B};
        }
        #custom-pingServer.down {
          color: #${scheme.base04};
        }

        /* BATTERY */

        #battery.warning:not(.charging) {
          background-color: #${scheme.base09};
          color: #${scheme.base00};
        }

        #battery.critical:not(.charging) {
          background-color: #${scheme.base08};
          color: #${scheme.base00};
        }

        #battery.charging {
          background-color: #${scheme.base0B};
          color: #${scheme.base00};
        }

        /* EDGE PADDING */

        #clock {
          margin-left: 20px;
        }

        #tray {
          margin-right: 4px;
        }

        #battery {
          margin-right: 20px;
        }


        /* Extra Silly Colours */
        #network {
          background: repeating-linear-gradient(
            to right,
            #C850D1 0px, #C850D1 1px,
            #E165DB 1px, #E165DB 3px,
            #E988E5 3px, #E988E5 5px,
            #E165DB 5px, #E165DB 6px
          );
          color: #000000;
        }
        #pulseaudio {
          background: repeating-linear-gradient(
            to right,
            #0BB5B0 0px, #0BB5B0 2px,
            #0FCFCA 2px, #0FCFCA 3px,
            #52DDD9 3px, #52DDD9 5px,
            #0FCFCA 5px, #0FCFCA 7px
          );
          color: #000000;
        }
        #custom-hyprsunset {
          background: repeating-linear-gradient(
            to right,
            #D9B13A 0px, #D9B13A 1px,
            #F2C849 1px, #F2C849 4px,
            #F5D570 4px, #F5D570 6px,
            #F2C849 6px, #F2C849 7px
          );
          color: #000000;
        }
        #battery {
          background: repeating-linear-gradient(
            to right,
            #3FC438 0px, #3FC438 2px,
            #51E04A 2px, #51E04A 4px,
            #7AE671 4px, #7AE671 5px,
            #51E04A 5px, #51E04A 7px
          );
          color: #000000;
        }

      '';
    };
  };
}
