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
          modules-left = ["clock" "hyprland/workspaces"];
          modules-center = [];
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
            format = "bat: {capacity}%";
            format-charging = "bat: {capacity}% (charging)";
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
            format = "net: up";
            format-wifi = "net: up";
            format-disconnected = "net: down";
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
          padding: 0 0px;
          margin: 4px 0;
          border-radius: 2px;
          background-color: #${scheme.base01}; 
        }

        #workspaces button {
          padding: 0 8px;
          margin: 0px 0;
          border-radius: 2px;
          background-color: #${scheme.base02}; 
        }

        #workspaces button.active {
          padding: 0 8px;
          margin: 0px 0;
          border-radius: 2px;
          background-color: #${scheme.base0E};
        }
        
        #battery.charging { color: #${scheme.base0B}; }
        #battery.sub50:not(.charging) { color: #${scheme.base0A}; }
        #battery.sub25:not(.charging) { color: #${scheme.base09}; }
        #battery.sub10:not(.charging) { color: #${scheme.base08}; }

        #clock { margin-left: 20px; }
        #battery { margin-right: 20px; }
      '';
    };
  };
}
