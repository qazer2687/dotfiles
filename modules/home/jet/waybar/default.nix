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

        @define-color rosewater  #f2d5cf;
        @define-color flamingo   #eebebe;
        @define-color pink       #f4b8e4;
        @define-color mauve      #ca9ee6;
        @define-color red        #e78284;
        @define-color maroon     #ea999c;
        @define-color peach      #ef9f76;
        @define-color yellow     #e5c890;
        @define-color green      #a6d189;
        @define-color teal       #81c8be;
        @define-color sky        #99d1db;
        @define-color sapphire   #85c1dc;
        @define-color blue       #8caaee;
        @define-color lavender   #babbf1;
        @define-color text       #c6d0f5;
        @define-color subtext1   #b5bfe2;
        @define-color subtext0   #a5adce;
        @define-color overlay2   #949cbb;
        @define-color overlay1   #838ba7;
        @define-color overlay0   #737994;
        @define-color surface2   #626880;
        @define-color surface1   #51576d;
        @define-color surface0   #414559;
        @define-color base       #303446;
        @define-color mantle     #292c3c;
        @define-color crust      #232634;

        * {
          border: none;
          border-radius: 0px;
          font-family: TX02;
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
