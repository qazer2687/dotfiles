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
    programs.waybar = {
      enable = true;
      settings = {
        mainBar = {
          layer = "top";
          position = "top";
          height = 48;
          margin = "0 0 0 0";
          modules-left = ["clock"];
          modules-center = ["hyprland/workspaces"];
          modules-right = ["tray" "network" "pulseaudio" "battery"];

          pulseaudio = {
            format = "vol: {volume}%";
            tooltip = false;
            format-muted = "vol: muted";
          };

          "custom/hyprsunset" = {
            exec = ''printf "󰖨 %sK" "$(hyprctl hyprsunset temperature)"'';
            signal = 1;
            format = "{}";
            tooltip = false;
          };

          clock = {
            format = "{:%H:%M}";
            format-alt = "{:%A %d, %H:%M}";
            tooltip = false;
          };

          tray = {
            icon-size = 28;
            spacing = 24;
            reverse-direction = true;
          };

          network = {
            tooltip = false;
            format = "net: up";
            format-wifi = "net: up";
            format-disconnected = "net: down";
            interval = 30;
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
              "10" = "10";
            };
          };

          backlight = {
            device = "apple-panel-bl";
            format = "BKL: {percent}%";
            tooltip = false;
          };
        };
      };

      style = ''
        * {
          border: none;
          border-radius: 0;
          font-family: "DepartureMono";
          font-size: 22px;
          min-height: 0;
        }

        window#waybar {
          background: #${scheme.base00};
        }

        #mpris, #clock, #language, #bluetooth, #custom-pingServer, #tray, #network, #battery, #pulseaudio {
          padding: 0 16px;
          margin: 4px;
          border-radius: 0px;
          border: 1px solid #${scheme.base02};
          background: #${scheme.base01};
          color: #${scheme.base05};
        }

        #workspaces {
          padding: 0 2px;
          margin: 4px;
          border-radius: 0px;
          background-color: transparent;
        }

        #workspaces button {
          padding: 0 16px;
          margin: 4px 2px;
          border-radius: 0px;
          background-color: #${scheme.base01};
          border: 1px solid #${scheme.base02};
        }

        #workspaces button.active {
          padding: 0 16px;
          margin: 4px 2px;
          border-radius: 0px;
          border: 1px solid #${scheme.base0E};
          background-color: #${scheme.base01};
        }
      '';
    };
  };
}
