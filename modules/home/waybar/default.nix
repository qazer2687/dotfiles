{
  lib,
  config,
  pkgs,
  ...
}: {
  options.modules.waybar.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.waybar.enable {
    wayland.windowManager.sway.config.bars = [
      {
        command = "${pkgs.waybar}/bin/waybar";
      }
    ];

    # Config
    programs.waybar = {
      enable = true;
      settings = [
        {
          layer = "top";
          height = 28;
          margin = "0 0 0 0";
          modules-left = ["clock" "sway/workspaces"];
          modules-center = [];
          modules-right = ["network" "pulseaudio" "battery"];

          # Pulseaudio
          pulseaudio = {
            tooltip = false;
            format = "{icon} {volume}%";
            format-muted = "  MUTED";
            format-icons = {
              default = [" " " " " "];
            };
          };

          # Clock
          clock = {
            format-alt = "{:%Y/%m/%d | %H:%M:%S}";
          };

          # Battery
          battery = {
            format = "{icon} {capacity}%"; # {icon}
            format-icons = [" " " " " " " " " "];
            format-charging = "  CHARGING";
            tooltip-format = "{icon} {capacity%}";
            tooltip = true;
            interval = 5;
          };

          # Workspaces
          "sway/workspaces" = {
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
              "0" = "10";
            };
            sort-by-number = true;
          };

          # Network
          network = {
            tooltip = false;
            format-wifi = "  {ipaddr}"; # 󱐋 {frequency}
            format-disconnected = "  DISCONNECTED";
            format-ethernet = "  {ipaddr}";
            interval = 5;
          };
        }
      ];

      style = ''
        * {
          font-family: Agave, FiraCode Mono Nerd Font;
          font-size: 11px;
          background-color: transparent;
          margin-left: 4px;
          margin-right: 4px;
        }

        window#waybar {
          background-color: #000;
        }

        #memory,
        #custom-power,
        #battery,
        #backlight,
        #pulseaudio,
        #network,
        #clock,
        #cpu,
        #memory,
        #temperature,
        #disk,
        #mpris,
        #tray {
          border-radius: 2px;
          padding: 2px 4px;
          margin-top: 4px;
          margin-bottom: 4px;
          color: #ffffff;
        }


        #workspaces button {
          all: initial; /* Remove GTK theme values (waybar #1351) */
          min-width: 0; /* Fix weird spacing in materia (waybar #450) */
          padding: 4px 4px;
          border-radius: 6px;
          color: #606060;
        }
        #workspaces button.visible {
          color: #ffffff;
        }

        /* EDGE MARGINS */
        #clock {
          margin-left: 10px;
          margin-right: 4px;
          background-color: #fff;
          color: #000;
        }
        #battery {
          margin-right: 10px;
        }
      '';
    };
  };
}
