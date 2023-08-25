

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
        height = 40;
        layer = "top";
        position = "top";
        modules-center = [ "sway/window" ];
        modules-left = [ "sway/workspaces" "sway/mode" ];
        modules-right = [
          "pulseaudio"
          "network"
          "cpu"
          "memory"
          "temperature"
          "battery"
          "clock"
          "tray"
        ];
        battery = {
          format = "{icon}";
          format-icons = [ "󰂎" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹" ];
          format-plugged = "󰂄";
          states = {
            critical = 10;
            warning = 20;
          };
          interval = 10;
        };
        clock = {
          format = "󰥔";
          tooltip-format = "{:%Y-%m-%d | %H:%M}";
        };
        cpu = {
          format = "󰘚";
          tooltip = true;
          interval = 2;
        };
        memory = {
          interval = 2;
          format = "󰍛";
        };
        network = {
          interval = 1;
          format = "󰤨";
          format-disconnected = "󰤭";
          format-ethernet = "󰈀";
        };
        pulseaudio = {
          format = "{icon}";
          format-icons = {
            default = [ "󰕿" "󰖀" "󰕾" ];
            headphones = "󰋋";
          };
          format-muted = "󰝟";
          format-source = " | 󰍬";
          format-source-muted = " | 󰍭";
          on-click = "pavucontrol";
        };
        "sway/mode" = {
          format = ''<span style="italic">{}</span>'';
        };
        temperature = {
          critical-threshold = 50;
          format = "{icon}";
          tooltip-format = "{temperatureC}°C";
          format-icons = [ "󱃃" "󰔏" "󱃂" ];
        };
      }];
      style = ''
        /* Global styles */
        #waybar {
          background-color: black;
        }

        #waybar * {
          font-family: 'FiraCode Nerd Font', monospace;
          color: white;
        }

        /* Battery module styles */
        #waybar battery {
          font-size: 18px;
        }

        /* Clock module styles */
        #waybar clock {
          font-size: 18px;
        }

        /* CPU module styles */
        #waybar cpu {
          font-size: 18px;
        }

        /* Memory module styles */
        #waybar memory {
          font-size: 18px;
        }

        /* Network module styles */
        #waybar network {
          font-size: 18px;
        }

        /* PulseAudio module styles */
        #waybar pulseaudio {
          font-size: 18px;
        }

        /* Temperature module styles */
        #waybar temperature {
          font-size: 18px;
        }

        /* Sway mode module styles */
        #waybar sway_mode {
          font-size: 18px;
          font-style: italic;
        }
      '';
    };
  };
}