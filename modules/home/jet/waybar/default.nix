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
          modules-left = [ "clock" "hyprland/workspaces" ];
          modules-center = [ ];
          modules-right = [ "tray" "backlight" "network" "pulseaudio" "battery" ];
          
          pulseaudio = {
            format = "VOL: {volume}%";
            tooltip = false;
            format-muted = "VOL: MUTED";
            format-icons = {
              default = [ " " " " " " ];
            };
          };
          
          clock = {
            format = "{:%A %d, %H:%M}";
            tooltip = false;
            margin-right = 15;
          };
          
          tray = {
            icon-size = 14;
            spacing = 10;
            reverse-direction = true;
          };
          
          battery = {
            tooltip = false;
            format = "BAT: {capacity}%";
            format-charging = "BAT: {capacity}% [CHARGING]";
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
            format = "PLAYING: {artist} - {title}";
            format-paused = "PAUSED: {artist} - {title}";
            player-icons = {
              default = " ";
            };
            artist-len = 20;
            title-len = 20;
            status-icons = {
              paused = " ";
            };
          };
        };
      };
      
      style = ''
        @define-color rosewater #f5e0dc;
        @define-color flamingo #f2cdcd;
        @define-color pink #f5c2e7;
        @define-color mauve #cba6f7;
        @define-color red #f38ba8;
        @define-color maroon #eba0ac;
        @define-color peach #fab387;
        @define-color yellow #f9e2af;
        @define-color green #a6e3a1;
        @define-color teal #94e2d5;
        @define-color sky #89dceb;
        @define-color sapphire #74c7ec;
        @define-color blue #89b4fa;
        @define-color lavender #b4befe;
        @define-color text #cdd6f4;
        @define-color subtext1 #bac2de;
        @define-color subtext0 #a6adc8;
        @define-color overlay2 #9399b2;
        @define-color overlay1 #7f849c;
        @define-color overlay0 #6c7086;
        @define-color surface2 #585b70;
        @define-color surface1 #45475a;
        @define-color surface0 #313244;
        @define-color base #1e1e2e;
        @define-color mantle #181825;
        @define-color crust #11111b;

        * {
            border: none;
            border-radius: 1px;
            font-family: Departure Mono, JetBrainsMono Nerd Font;
            font-size: 11px;
            min-height: 0;
        }

        window#waybar {
            background-color: #000000;
            color: @text;
        }

        tooltip {
            background-color: @base;
            border: 1px solid @surface1;
            color: @text;
        }

        #workspaces button {
          padding: 0 0;
          background-color: @mauve;
          color: @mantle;
        }

        #workspaces button.focused {
          background-color: @text;
          color: @base;
        }

        #workspaces button.urgent {
          background-color: @red;
          color: @mantle;
        }

        #mpris, #custom-weather, #clock, #language, #pulseaudio, #bluetooth, #network, 
        #memory, #cpu, #temperature, #disk, #custom-kernel, #idle_inhibitor, #mode, 
        #backlight, #battery, #workspaces button, #workspaces button.focused {
          padding: 0 10px;
          margin: 5px 1px;
          background-color: @mauve;
          color: @mantle;
        }

        #workspaces button.focused {
          background-color: @mantle;
          color: @mauve;
        }

        /* Pad Edges */
        #clock {
          padding-left: 16px;
        }
        #battery {
          padding-right: 16px;
        }

        #window, #workspaces {
          margin: 0 4px;
        }
      '';
    };
  };
}
