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
          height = 24;
          margin = "0 0 0 0";
          modules-left = ["custom/pingServer"];
          modules-center = ["hyprland/workspaces" ];
          modules-right = ["tray" "network" "pulseaudio" "clock"];

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
            format-wifi = "NET: {essid}";
            format-alt = "{essid} - {ifname} - {ipaddr}";
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
          background: rgba(17, 17, 27, 0.2);
        }

        #mpris, #clock, #language, #pulseaudio, #bluetooth, #network,
        #memory, #cpu, #temperature, #disk, #custom-kernel, #custom-hyprsunset, #idle_inhibitor, #mode,
        #backlight, #battery, #custom-pingServer, #workspaces button, #workspaces button.active {
          padding: 0 8px;
          margin: 2px 2px;
          border-radius: 2px;
          background: rgba(24, 24, 37, 0.4);
          color: #${scheme.base05};
        }

        #workspaces {
          color: transparent;
          background: rgba(24, 24, 37, 0.4);
          border-radius: 2px;
          margin: 2px 4px;
        }
        #workspaces button {
          background-color: transparent;
          border-radius: 0;
          margin: 0px 0px;
        }
        #workspaces button.active {
          background-color: transparent;
          border-radius: 0;
          margin: 0px 0px;
          box-shadow: inset 0 -1px 0 #${scheme.base01};
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

        #workspaces {
          margin-left: 16px;
          margin-right: 16px;
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
