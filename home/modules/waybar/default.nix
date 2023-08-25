

{
  pkgs,
  lib,
  inputs,
  config,
  ...
}: {

  options.homeModules.waybar.ruby.enable = lib.mkEnableOption "";

  config = lib.mkIf config.homeModules.waybar.ruby.enable {
    programs.waybar = {
      enable = true;
      settings = [{
        height = 15;
        layer = "top";
        position = "top";
        modules-center = [ "sway/window" ];
        modules-left = [ "sway/workspaces"];
        modules-right = [
          "pulseaudio"
          "custom/seperator-beam"
          "network"
          "custom/seperator-beam"
          "cpu"
          "custom/seperator-beam"
          "memory"
          "custom/seperator-beam"
          "temperature"
          "custom/seperator-beam"
          "battery"
          "custom/seperator-beam"
          "clock"
          "custom/seperator-beam"
          "tray"
          "custom/seperator-blank"
        ];
        "sway/workspaces" = {
          format = " {name} ";
        };
        battery = {
          format = " {icon} ";
          format-icons = [ "󰂎" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹" ];
          format-plugged = "󰂄";
          states = {
            critical = 10;
            warning = 20;
          };
          interval = 10;
        };
        clock = {
          format = " 󰥔 ";
          tooltip-format = "{:%Y-%m-%d | %H:%M}";
        };
        cpu = {
          format = " 󰘚 ";
          tooltip = true;
          interval = 2;
        };
        memory = {
          interval = 2;
          format = " 󰍛 ";
        };
        network = {
          interval = 1;
          format = " 󰤨 ";
          format-disconnected = "󰤭";
          format-ethernet = "󰈀";
        };
        pulseaudio = {
          format = " {icon} ";
          format-icons = {
            default = [ "󰕿" "󰖀" "󰕾" ];
            headphones = "󰋋";
          };
          format-muted = "󰝟";
          format-source = "󰍬";
          format-source-muted = "󰍭";
          on-click = "pavucontrol";
        };
        temperature = {
          critical-threshold = 50;
          format = " {icon} ";
          tooltip-format = "{temperatureC}°C";
          format-icons = [ "󱃃" "󰔏" "󱃂" ];
        };
        "custom/seperator-blank" = {
          format = " ";
        };
        "custom/seperator-beam" = {
          format = "|";
        };
      }];
      style = ''
        /* Global styles */
        #waybar {
          background-color: black;
        }
        #waybar * {
          font-family: 'FiraCode Nerd Font', monospace;
          font-size: 15px;
          color: white;
        }
      '';
    };
  };
}