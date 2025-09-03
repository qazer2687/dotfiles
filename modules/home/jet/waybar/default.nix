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
      settings = {
        mainBar = {
          layer = "top";
          height = 28;
          margin = "0 0 0 0";
          modules-left = ["clock" "hyprland/workspaces" "mpris"];
          modules-center = [];
          modules-right = ["tray" "network" "pulseaudio" "battery"];

          pulseaudio = {
            format = "VOL: {volume}%";
            tooltip = false;
            format-muted = "VOL: MUTED";
          };

          "custom/hyprsunset" = {
            exec = ''printf "TEMP: %sK" "$(hyprctl hyprsunset temperature)"'';
            signal = 1;
            format = "{}";
            tooltip = false;
          };

          clock = {
            format = "{:%A %d, %H:%M}";
            tooltip = false;
            margin-right = 15;
          };

          tray = {
            icon-size = 14;
            spacing = 12;
            reverse-direction = true;
          };

          battery = {
            tooltip = false;
            format = "BAT: {capacity}%";
            format-charging = "BAT: {capacity}%";
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
            };
          };

          "niri/workspaces" = {
            format = "{icon}";
            format-icons = {
              "1" = "1";
              "2" = "2";
              "3" = "3";
              "4" = "4";
              "5" = "5";
            };
          };

          backlight = {
            device = "apple-panel-bl";
            format = "BKL: {percent}%";
            tooltip = false;
          };

          network = {
            tooltip = false;
            format-wifi = "NET: {essid}";
            family = "ipv4";
            format-disconnected = "NET: OFFLINE";
            format-ethernet = "NET: WIRED";
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
        @define-color highlight @mauve;

        @define-color rosewater #f4dbd6;
        @define-color flamingo  #f0c6c6;
        @define-color pink      #f5bde6;
        @define-color mauve     #c6a0f6;
        @define-color red       #ed8796;
        @define-color maroon    #ee99a0;
        @define-color peach     #f5a97f;
        @define-color yellow    #eed49f;
        @define-color green     #a6da95;
        @define-color teal      #8bd5ca;
        @define-color sky       #91d7e3;
        @define-color sapphire  #7dc4e4;
        @define-color blue      #8aadf4;
        @define-color lavender  #b7bdf8;
        @define-color text      #cad3f5;
        @define-color subtext1  #b8c0e0;
        @define-color subtext0  #a5adcb;
        @define-color overlay2  #939ab7;
        @define-color overlay1  #8087a2;
        @define-color overlay0  #6e738d;
        @define-color surface2  #5b6078;
        @define-color surface1  #494d64;
        @define-color surface0  #363a4f;
        @define-color base      #24273a;
        @define-color mantle    #1e2030;
        @define-color crust     #181926;

        * {
          border: none;
          border-radius: 0px;
          font-family: TX-02;
          font-size: 11px;
          min-height: 0;
        }

        window#waybar {
          background-color: @crust;
        }

        #mpris, #clock, #language, #pulseaudio, #bluetooth, #network,
        #memory, #cpu, #temperature, #disk, #custom-kernel, #custom-hyprsunset, #idle_inhibitor, #mode,
        #backlight, #battery, #workspaces button, #workspaces button.focused,
        #workspaces button.active {
          padding: 0 8px;
          margin: 4px 2px;
          border-radius: 2px;
          background-color: @base;
          color: @text;
        }

        #mpris {
          border: 1px solid @mauve;
        }

        #workspaces button.active {
          background-color: @highlight;
          color: @mantle;
        }

        #battery.warning {
          background-color: @peach;
          color: @mantle;
        }

        #battery.critical {
          background-color: @red;
          color: @mantle;
        }

        #battery.charging {
          background-color: @green;
          color: @mantle;
        }

        /* Pad Edges */
        #clock {
          margin-left: 16px;
        }

        #tray {
          margin-right: 4px;
        }

        #battery {
          margin-right: 16px;
        }
      '';
    };
  };
}
