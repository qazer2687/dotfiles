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
          modules-left = ["clock" "hyprland/workspaces" "custom/pingServer" "tray"];
          modules-center = [];
          modules-right = ["network" "pulseaudio" "battery"];


          
          pulseaudio = {
            format = "{icon} | ";
            tooltip = false;
            format-muted = "";
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
            format = "{icon}";
            format-charging = "{icon}";
            format-icons = ["" "" "" "" ""];
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
            format = "{icon} | ";
            format-alt = "{icon}";
            format-disconnected = "󰖪";
            format-icons = {
              wifi = ["󰣾" "󰣴" "󰣶" "󰣸" "󰣺"];
              ethernet = "󰈀";
            };
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
        border-radius: 0;
        font-family: "Departure Mono", "FiraCode Nerd Font";
        font-size: 11px;
        min-height: 0;
      }

      window#waybar {
        background: linear-gradient(to right, #000000 50%, transparent 50%);
      }

      /* Base module styling */
      #mpris, #clock, #language, #bluetooth, #memory, #cpu, #temperature, 
      #disk, #custom-kernel, #idle_inhibitor, #mode, #backlight, 
      #custom-pingServer, #workspaces button, #workspaces button.active, #tray {
        padding: 0 8px;
        margin: 2px;
        border-radius: 4px;
        background-color: #${scheme.base01};
        color: #${scheme.base05};
      }

      /* Workspaces */
      #workspaces {
        color: transparent;
        background-color: #${scheme.base01};
        border-radius: 4px;
        margin: 2px;
      }

      #workspaces button {
        background-color: transparent;
        margin: 0;
      }

      #workspaces button.active {
        background-color: #${scheme.base02};
      }

      /* Server ping states */
      #custom-pingServer.up {
        color: #${scheme.base0B};
      }

      #custom-pingServer.down {
        color: #${scheme.base04};
      }

      /* Battery states */
      #battery.warning:not(.charging) {
        color: #${scheme.base09};
      }

      #battery.critical:not(.charging) {
        color: #${scheme.base08};
      }

      #battery.charging {
        color: #${scheme.base0B};
      }

      /* Edge modules with special styling */
      #clock {
        padding: 0 8px;
        margin: 2px 2px 2px 20px;
        border-radius: 4px;
        background-color: #${scheme.base01};
        color: #${scheme.base05};
      }

      #network, #pulseaudio, #custom-hyprsunset, #battery {
        background: rgba(255, 255, 255, 0.01);
        color: #000000;
        padding: 0 10px;
        margin: 2px 0 0 0;
        border-radius: 0;
      }

      #network {
        border-radius: 8px 0 0 8px;
      }

      #battery {
        border-radius: 0 8px 8px 0;
        margin-right: 20px;
      }
      '';
    };
  };
}
