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
          modules-left = ["niri/workspaces" "custom/pingServer" "tray"];
          modules-center = [];
          modules-right = ["network" "pulseaudio" "battery" "clock" ];

          pulseaudio = {
            format = "{icon}";
            format-alt = "{icon} {volume}%";
            tooltip = false;
            format-muted = "";
            format-icons = {
              # Shift the point where the icons change lower, because I never listen above like 20%.
              default = ["" "" "" "" "" "" "" "" "" "" "" "" "" "" ""];
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
            format = "{icon}";
            format-alt = "{icon} {capacity}%";
            format-charging = "";
            interval = 30;
            states = {
              sub50 = 50;
              sub25 = 25; 
              sub10 = 10;
            };
            format-icons = ["" "" "" ""];
            margin-left = 15;
          };

          network = {
            tooltip = false;
            format = "{icon}";
            format-wifi = "{icon}";
            format-disconnected = "";
            interval = 30;
            format-icons = [""];
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
          border-radius: 0;
          font-family: "PragmataPro", "lucide";
          font-size: 11px;
          min-height: 0;
        }

        window#waybar {
          background: #${scheme.base00};
        }

        #network, #battery, #pulseaudio {
          padding: 0 4px;
          margin: 0px;
          border-radius: 0;
          background: #${scheme.base01};
          color: #${scheme.base05};
        }

        #network {
          border-top-left-radius: 2px;
          border-bottom-left-radius: 2px;
          border-top-right-radius: 0;
          border-bottom-right-radius: 0;
        }

        #battery {
          border-top-right-radius: 2px;
          border-bottom-right-radius: 2px;
          border-top-left-radius: 0;
          border-bottom-left-radius: 0;
        }

        #mpris, #clock, #language, #bluetooth, #custom-pingServer, #tray {
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
          padding: 0px;
        }

        #workspaces button {
          padding: 0 8px;
          margin: 0 1px;
          border-radius: 2px;
          background: transparent;
          color: #${scheme.base05};
        }

        #workspaces button.active {
          background: #${scheme.base05};
          color: #${scheme.base01};
          padding: 0 8px;
          margin: 0 0px;
        }

        #custom-pingServer.up { color: #${scheme.base0B}; }
        #custom-pingServer.down { color: #${scheme.base08}; }

        #battery.charging { color: #${scheme.base0B}; }
        #battery.sub50:not(.charging) { color: #${scheme.base0A}; }
        #battery.sub25:not(.charging) { color: #${scheme.base09}; }
        #battery.sub10:not(.charging) { color: #${scheme.base08}; }

        #workspaces { margin-left: 20px; }
        #clock { margin-right: 20px; }
      '';
    };
  };
}
