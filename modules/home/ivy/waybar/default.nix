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
    home.packages = [pkgs.jq];
    programs.waybar = {
      enable = true;
      settings = {
        mainBar = {
          layer = "top";
          position = "left";
          width = 40;
          margin = "0 0 0 0";
          modules-left = ["clock"];
          modules-center = ["hyprland/workspaces"];
          modules-right = ["tray" "network" "pulseaudio" "battery"];
          pulseaudio = {
            format = "{volume}%";
            tooltip = true;
            tooltip-format = "Volume: {volume}%";
            format-muted = "M";
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
            format = "{:%H\n%M}";
            format-alt = "{:%d\n%m}";
            tooltip = true;
            tooltip-format = "{:%A, %B %d, %Y - %H:%M}";
          };
          tray = {
            icon-size = 16;
            spacing = 8;
            reverse-direction = false;
          };
          battery = {
            tooltip = true;
            tooltip-format = "Battery: {capacity}%";
            format = "{capacity}%";
            format-charging = "{capacity}%\n⚡";
            interval = 30;
            states = {
              sub50 = 50;
              sub25 = 25;
              sub10 = 10;
            };
          };
          network = {
            tooltip = true;
            tooltip-format = "Network: {essid}";
            format = "󰈁";
            format-wifi = "󰖨";
            format-disconnected = "󰖪";
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
            format = "{percent}%";
            tooltip = true;
            tooltip-format = "Backlight: {percent}%";
          };
        };
      };
      style = ''
        * {
          border: none;
          border-radius: 0;
          font-family: "PragmataPro";
          font-size: 12px;
          min-height: 0;
        }
        window#waybar {
          background: #${scheme.base00};
        }
        #mpris, #clock, #language, #bluetooth, #custom-pingServer, #tray, #network, #battery, #pulseaudio {
          padding: 8px 4px;
          margin: 4px 2px;
          border-radius: 2px;
          background: #${scheme.base01};
          color: #${scheme.base05};
        }
        #workspaces {
          padding: 2px 0;
          margin: 4px 2px;
          border-radius: 2px;
          background-color: #${scheme.base01};
        }
        #workspaces button {
          padding: 6px 8px;
          margin: 2px 0;
          border-radius: 2px;
          background-color: #${scheme.base02};
        }
        #workspaces button.active {
          padding: 6px 8px;
          margin: 2px 0;
          border-radius: 2px;
          background-color: #${scheme.base09};
        }
        #battery.charging { color: #${scheme.base0B}; }
        #battery.sub50:not(.charging) { color: #${scheme.base0A}; }
        #battery.sub25:not(.charging) { color: #${scheme.base09}; }
        #battery.sub10:not(.charging) { color: #${scheme.base08}; }
      '';
    };
  };
}