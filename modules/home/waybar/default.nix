{
  pkgs,
  lib,
  config,
  ...
}: {
  options.modules.waybar.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.waybar.enable {
    # Dependencies
    home.packages = with pkgs; [
      playerctl
    ];

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
          height = 40;
          layer = "top";
          modules-left = ["clock" "sway/workspaces" "mpris"];
          modules-center = [];
          modules-right = ["network" "pulseaudio" "temperature" "battery"];
          pulseaudio = {
            tooltip = false;
            scroll-step = 1;
            on-click = "pamixer -t";
            format = "{icon} {volume}%";
            format-muted = "󰝟";
            format-icons = {
              default = ["󰕿" "󰖀" "󰕾"];
            };
          };
          clock = {
            format-alt = "{:%Y/%m/%d | %H:%M:%S}";
          };
          battery = {
            format = "{icon} {}%";
            format-icons = ["󰂎" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
            full-at = 95;
            format-full = "{icon}";
            format-charging = "󰂄 {}%";

            states = {
              full = 95;
              critical = 25;
            };
            interval = 60;
          };
          mpris = {
            format = "{player_icon} {artist} - {title}";
            format-paused = "{status_icon} {artist} - {title}";
            player-icons = {
              default = "󰐊";
            };
            status-icons = {
              paused = "󰏤";
            };
          };
          network = {
            tooltip = false;
            format-wifi = " {essid}"; # 󱐋 {frequency}
            format-disconnected = " Disconnected";
            format-alt = "{ipaddr}";
            format-ethernet = "󰈁";
            interval = 5;
          };
          cpu = {
            tooltip = false;
            format = " {}%";
            interval = 2;
          };
          memory = {
            tooltip = false;
            format = "󰘚 {}%";
            interval = 2;
          };
          temperature = {
            tooltip = false;
            thermal-zone = 5; # x86_pkg_temp
            critical-threshold = 70;
            format = " {temperatureC}°C";
            format-critical = " {temperatureC}°C";
            interval = 10;
          };
          disk = {
            tooltip = false;
            format = "󰋊 {percentage_used}%";
            interval = 120;
          };
        }
      ];
      style = ''
        * {
          border: none;
          border-radius: 0;
          font-family: FiraCode Nerd Font;
          font-size: 14px;
          min-height: 24px;
        }

        window#waybar {
          background: transparent;
        }

        window#waybar.hidden {
          opacity: 0.2;
        }

        #window {
          margin-top: 8px;
          padding-left: 16px;
          padding-right: 16px;
          border-radius: 5px;
          transition: none;
          color: transparent;
          background: transparent;
        }

        window#waybar.termite #window,
        window#waybar.Firefox #window,
        window#waybar.Navigator #window,
        window#waybar.PCSX2 #window {
            color: #000000;
          background: #ffffff;
        }

        #workspaces {
          margin-top: 8px;
          margin-left: 4px;
          margin-right: 4px;
          margin-bottom: 0;
          border-radius: 5px;
          background: #000000;
          transition: none;
        }

        #workspaces button {
          transition: none;
          color: #ffffff;
          background: transparent;
          font-size: 14px;
        }

        #workspaces button.focused {
          color: #ffffff;
        }

        #workspaces button:hover {
          transition: none;
          box-shadow: inherit;
          text-shadow: inherit;
          color: #ffffff;
        }

        #mpris {
          margin-top: 8px;
          margin-left: 4px;
          margin-right: 4px;
          padding-left: 16px;
          padding-right: 16px;
          margin-bottom: 0;
          border-radius: 5px;
          background: #282a36;
          transition: none;
          color: #ffffff;
          background: #000000;
        }

        #mpd.disconnected,
        #mpd.stopped {
          color: #ffffff;
          background: #000000;
        }

        #network {
          margin-top: 8px;
          margin-left: 4px;
          margin-right: 4px;
          padding-left: 16px;
          padding-right: 16px;
          margin-bottom: 0;
          border-radius: 5px;
          transition: none;
          color: #ffffff;
          background: #000000;
        }

        #pulseaudio {
          margin-top: 8px;
          margin-left: 4px;
          margin-right: 4px;
          padding-left: 16px;
          padding-right: 16px;
          margin-bottom: 0;
          border-radius: 5px;
          transition: none;
          color: #ffffff;
          background: #000000;
        }

        #pulseaudio.muted {
          color: #ff6666;
        }

        #temperature {
          margin-top: 8px;
          margin-left: 4px;
          margin-right: 4px;
          padding-left: 16px;
          padding-right: 16px;
          margin-bottom: 0;
          border-radius: 5px;
          transition: none;
          color: #ffffff;
          background: #000000;
        }

        #temperature.critical {
          color: #ff6666;
        }

        #cpu {
          margin-top: 8px;
          margin-left: 4px;
          margin-right: 4px;
          padding-left: 16px;
          padding-right: 16px;
          margin-bottom: 0;
          border-radius: 5px;
          transition: none;
          color: #ffffff;
          background: #000000;
        }

        #memory {
          margin-top: 8px;
          margin-left: 4px;
          margin-right: 4px;
          padding-left: 16px;
          padding-right: 16px;
          margin-bottom: 0;
          border-radius: 5px;
          transition: none;
          color: #ffffff;
          background: #000000;
        }

        #battery {
          margin-top: 8px;
          margin-left: 8px;
          margin-left: 4px;
          margin-right: 8px;
          padding-left: 16px;
          padding-right: 16px;
          margin-bottom: 0;
          border-radius: 5px;
          transition: none;
          color: #ffffff;
          background: #000000;
        }

        #battery.critical {
          color: #ff6666;
        }

        #battery.full {
          color: #66ff66;
        }

        #disk {
          margin-top: 8px;
          margin-left: 4px;
          margin-right: 4px;
          padding-left: 16px;
          padding-right: 16px;
          margin-bottom: 0;
          border-radius: 5px;
          transition: none;
          color: #ffffff;
          background: #000000;
        }

        #clock {
          margin-top: 8px;
          margin-left: 8px;
          margin-right: 4px;
          padding-left: 16px;
          padding-right: 16px;
          margin-bottom: 0;
          border-radius: 5px;
          transition: none;
          color: #ffffff;
          background: #000000;
        }
      '';
    };
  };
}
