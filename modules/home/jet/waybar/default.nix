{
  lib,
  config,
  base16,
  pkgs,
  ...
}: let
  scheme = base16 "framer";
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
          modules-left = ["clock" "niri/workspaces" "custom/pingServer" "tray"];
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

          "niri/workspaces" = {
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
        /* --- WAYBAR CSS WITH WORKSPACE ANIMATIONS --- */

        * {
          border: none;
          border-radius: 0;
          font-family: "PragmataPro", "FiraCode Nerd Font";
          font-size: 11px;
          min-height: 0;
        }

        window#waybar {
          background: #${scheme.base00};
        }

        /* Base modules */
        #mpris, #clock, #language, #pulseaudio, #bluetooth, #network,
        #battery, #custom-pingServer, #tray {
          padding: 0 8px;
          margin: 2px;
          border-radius: 2px;
          background: #${scheme.base01};
          color: #${scheme.base05};
        }

        #workspaces {
          background: #${scheme.base01};
          border-radius: 2px;
          margin: 2px;
          color: transparent;
        }

        #workspaces button {
          padding: 0 8px;
          margin: 0;
          border-radius: 2px;
          background: transparent;
          color: #${scheme.base05};
          transition: all 0.1s ease-out; /* Smooth hover/off transitions */
        }

        /* --- LIQUID GLASS ANIMATION ---
          Uses padding/opacity (GTK-safe) instead of transform
          Creates expand → overshoot → settle effect */
        #workspaces button.active {
          background: #${scheme.base02};
          animation-name: workspaceActivate;
          animation-duration: 0.45s;
          animation-timing-function: cubic-bezier(0.34, 1.56, 0.64, 1); /* Elastic but GTK-safe */
          animation-fill-mode: both;
        }

        @keyframes workspaceActivate {
          0% {
            /* Compressed & faded */
            padding: 0 5px;
            margin: 0 3px;  /* Compensates for padding change */
            opacity: 0.7;
          }
          45% {
            /* Peak expansion - "fling" */
            padding: 0 15px;
            margin: 0 -7px;
            opacity: 1;
          }
          75% {
            /* First settle */
            padding: 0 8px;
            margin: 0 0px;
          }
          90% {
            /* Minor overshoot bounce */
            padding: 0 9px;
            margin: 0 -1px;
          }
          100% {
            /* Final locked state */
            padding: 0 8px;
            margin: 0;
            opacity: 1;
          }
        }

        /* Status colors */
        #custom-pingServer.up { color: #${scheme.base0B}; }
        #custom-pingServer.down { color: #${scheme.base08}; }

        #battery.charging { color: #${scheme.base0B}; }
        #battery.sub50:not(.charging) { color: #${scheme.base0A}; }
        #battery.sub25:not(.charging) { color: #${scheme.base09}; }
        #battery.sub10:not(.charging) { color: #${scheme.base08}; }

        /* Edge margins */
        #clock { margin-left: 20px; }
        #battery { margin-right: 20px; }
      '';
    };
  };
}
