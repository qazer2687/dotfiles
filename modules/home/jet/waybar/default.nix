{
  lib,
  config,
  base16,
  pkgs,
  ...
}: let
  scheme = base16 "gruvbox-dark-hard";
in {
  options.modules.waybar.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.waybar.enable {
    home.file.".config/waybar/scripts/pingServer.sh".text = builtins.readFile ./scripts/pingServer.sh;
    home.file.".config/waybar/scripts/pingServer.sh".executable = true;
    
    home.packages = [ pkgs.jq ];

    programs.waybar = {
      enable = true;
      settings = {
        mainBar = {
          layer = "top";
          height = 28;
          margin = "0 0 0 0";
          modules-left = ["clock" "hyprland/workspaces" "custom/pingServer" "tray"];
          modules-center = [];
          modules-right = ["network" "pulseaudio" "battery"];

          pulseaudio = {
            format = "VOL: {volume}%";
            tooltip = false;
            format-muted = "VOL: MUTED";
            format-icons = {
              default = ["" "" ""];
            };
          };

          "custom/hyprsunset" = {
            exec = ''printf "󰖨 %sK" "$(hyprctl hyprsunset temperature)"'';
            signal = 1;
            format = "{}";
            tooltip = false;
          };

          "custom/pingServer" = {
            exec = "$HOME/.config/waybar/scripts/pingServer.sh";
            interval = 20;
            return-type = "json";
          };


          clock = {
            format-alt = "{:%H:%M}";
            format = "{:%A %d, %H:%M}";
            tooltip = false;
          };

          tray = {
            icon-size = 14;
            spacing = 12;
            reverse-direction = true;
          };

          battery = {
            tooltip = false;
            format = "BAT: {capacity}% [{power}W]";
            format-charging = "BAT: {capacity}% [{power}W] (CHARGING)";
            interval = 1;
            states = {
              sub50 = 50;
              sub25 = 25; 
              sub10 = 10;
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
            format = "{icon}";
            format-ethernet = "NET: {ipaddr} ↗ {bandwidthUpBytes} ↘ {bandwidthDownBytes}";
            format-wifi = "NET: {ipaddr} ↗ {bandwidthUpBytes} ↘ {bandwidthDownBytes}";
            format-disconnected = "NET: DISCONNECTED";
            format-icons = {
              wifi = ["󰣾" "󰣴" "󰣶" "󰣸" "󰣺"];
              ethernet = "󰈀";
            };
            interval = 1;
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
          font-family: "PragmataPro", "FiraCode Nerd Font";
          font-size: 11px;
          min-height: 0;
        }

        window#waybar {
          background-color: #${scheme.base00};
        }

        #mpris, #clock, #language,
        #pulseaudio, #bluetooth, #network,
        #battery, #custom-pingServer,
        #workspaces button, #workspaces button.active,
        #tray {
          padding: 0 8px;
          margin: 2px 2px;
          border-radius: 2px;
        
          background-color: #${scheme.base01};
          color: #${scheme.base05};
        }

        /* WORKSPACES */

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

        /* MICA */

        #custom-pingServer.up {
          color: #${scheme.base0B};
        }
        #custom-pingServer.down {
          color: #${scheme.base08};
        }

        /* BATTERY */

        #battery.sub50:not(.charging) {
          color: #${scheme.base0A};
        }

        #battery.sub25:not(.charging) {
          color: #${scheme.base09};
        }

        #battery.sub10:not(.charging) {
          color: #${scheme.base08};
        }

        #battery.charging {
          color: #${scheme.base0B};
        }

        /* EDGE MARGIN */

        #clock {
          margin-left: 20px;
        }

        #battery {
          margin-right: 20px;
        }
      '';
    };
  };
}
