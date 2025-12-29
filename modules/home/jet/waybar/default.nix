{
  lib,
  config,
  base16,
  pkgs,
  ...
}: let
  scheme = base16 "catppuccin-mocha";
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
          modules-left = ["hyprland/workspaces"];
          modules-center = [];
          modules-right = ["network" "pulseaudio" "battery" "clock"];

          pulseaudio = {
            format = "{volume}";
            tooltip = false;
            format-muted = "muted";
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
            format = "{capacity}";
            interval = 30;
            states = {
              sub50 = 50;
              sub25 = 25; 
              sub10 = 10;
            };
            format-icons = ["/    " "//   " "///  " "//// " "/////"];
            margin-left = 15;
          };

          network = {
            tooltip = false;
            format = "1";
            format-wifi = "1";
            format-disconnected = "0";
            interval = 30;
          };

          "hyprland/workspaces" = {
            format = "";
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
          font-size: 11px;
          min-height: 0;
        }

        window#waybar {
          background: #${scheme.base00};
        }

        #mpris, #clock, #language, #bluetooth, #custom-pingServer, #tray, #network, #battery, #pulseaudio {
          padding: 0 8px;
          margin: 2px;
          border-radius: 2px;
          background: #${scheme.base01};
          color: #${scheme.base05};
        }

        #workspaces {
            background: #${scheme.base01};
            margin: 2px;
        }

        #workspaces button {
          padding: 0 4px;
          margin: 1px;
          background-color: #${scheme.base02}; 
        }

        #workspaces button.active {
          padding: 0 4px;
          margin: 1px;
          background-color: #${scheme.base0E};
        }
        
       /* #custom-pingServer.up { color: #${scheme.base0E}; }
        #custom-pingServer.down { color: #${scheme.base08}; }*/

        #battery.charging { color: #${scheme.base0E}; }
        #battery.sub50:not(.charging) { color: #${scheme.base0A}; }
        #battery.sub25:not(.charging) { color: #${scheme.base09}; }
        #battery.sub10:not(.charging) { color: #${scheme.base08}; }

        #workspaces { margin-left: 20px; }
        #clock { margin-right: 20px; }
      '';
    };
  };
}
