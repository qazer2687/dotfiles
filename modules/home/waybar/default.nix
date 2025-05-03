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

    home.packages = with pkgs; [
      # MPRIS Dependency
      playerctl
    ];

    programs.waybar = {
      enable = true;
      systemd.enable = false;
      settings = [
        {
          layer = "top";
          height = 28;
          margin = "0 250 0 250";
          modules-left = ["clock" "hyprland/workspaces"];
          modules-center = [];
          modules-right = ["pulseaudio" "battery"];

          pulseaudio = {
            format = "{icon} {volume}%";
            tooltip = false;
            format-muted = "  MUTED";
            format-icons = {
              default = [" " " " " "];
            };
          };
          clock = {
            format = "{:%A %d, %H:%M}";
            #format-alt = "{:%Y/%m/%d | %H:%M:%S}";
            tooltip = false;
          };

          battery = {
            tooltip = false;
            format = "{icon} {capacity}%";
            format-icons = [" " " " " " " " " "];
            format-charging = "󱐋 {capacity}%";
            interval = 10;
          };

          "hyprland/workspaces" = {
            format = "";
            format-icons = {
              "1" = "a";
              "2" = "";
              "3" = "3";
              "4" = "4";
              "5" = "5";
              "6" = "6";
              "7" = "7";
              "8" = "8";
              "9" = "9";
              "0" = "10";
            };
            #sort-by-number = true;
          };

          backlight = {
            device = "apple-panel-bl";
            format = "{icon}";
            tooltip = true;
            tooltip-format = "{percent}%";
            format-icons = ["󰃞 " "󰃟 " "󰃠 "];
          };

          network = {
            tooltip = false;
            format-wifi = "  {ipaddr}"; # 󱐋 {frequency}
            family = "ipv4";
            format-disconnected = " ";
            format-ethernet = " ";
            interval = 10;
          };

          mpris = {
            tooltip = false;
            format = "{player_icon} {artist} - {title}";
            format-paused = "{status_icon} {artist} - {title}";
            player-icons = {
              default = " ";
            };
            artist-len = 24;
            title-len = 34;
            status-icons = {
              paused = " ";
            };
          };
        }
      ];

      style = ''
        * {
          font-family: Departure Mono, FiraCode Mono Nerd Font;
          font-size: 11px;
          background-color: transparent;
          margin-left: 4px;
          margin-right: 4px;
        }

        window#waybar {
          background-color: #000000;
          border-radius: 0px 0px 4px 4px;
        }

        tooltip {
          background: #000000;
          border: 1px solid rgba(255, 255, 255, 1);
        }
        tooltip label {
          color: white;
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
          padding: 4px 0px;
          border-radius: 6px;
          color:rgb(138, 138, 138);
        }
        #workspaces button.active {
          color: #ffffff;
        }
        #workspaces button.focused{
          color: #ffffff;
        }

        /* White MPRIS Background */
        #mpris {
          background-color: #ffffff;
          color: #000000;
        }

      /* EDGE MARGINS */
      /*
        #clock {
          margin-left: 10px;
          margin-right: 4px;
          background-color: #ffffff;
          color: #000000;
        }
        #battery {
          margin-right: 10px;
        }
      */
      '';
    };
  };
}
