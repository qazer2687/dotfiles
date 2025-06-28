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
        @define-color darkest #0d0d0d;
        @define-color darker #1a1a1a;
        @define-color base #2d2d2d;
        @define-color lighter #404040;
        @define-color lightest #999999;
        @define-color text #b8b8b8;
  
        * {
            font-family: "Departure Mono", "FiraCode Mono Nerd Font";
            font-size: 11px;
            background-color: transparent;
        }
  
        /* Base styles */
        window#waybar {
            background-color: #000000;
            border-radius: 0;
        }
  
        /* Common module styling */
        #memory,
        #custom-power,
        #battery,
        #backlight,
        #pulseaudio,
        #network,
        #cpu,
        #temperature,
        #disk,
        #mpris,
        #tray,
        #tray menu {
            margin: 2px 1px;
            padding: 3px 6px;
            border-radius: 0;
            color: @text;
            background-color: @base;
            border: 1px solid;
            border-color: @lightest @darkest @darkest @lightest;
            box-shadow: inset 1px 1px 0px rgba(255, 255, 255, 0.1), inset -1px -1px 0px rgba(0, 0, 0, 0.3);
            font-weight: normal;
        }
  
        /* Special module styling */
        #mpris {
            background-color: @base;
            color: @text;
            border: 1px solid;
            border-color: @lightest @darkest @darkest @lightest;
        }
  
        #workspaces button {
          all: initial;
          min-width: 0;
          padding: 4px 8px;
          border-radius: 0;
          color: @text;
          background-color: @base;
          border: 1px solid;
          border-color: @lightest @darkest @darkest @lightest;
          box-shadow: inset 1px 1px 0px rgba(255, 255, 255, 0.1), inset -1px -1px 0px rgba(0, 0, 0, 0.3);
          margin: 2px 1px;
        }
  
        #workspaces button.focused {
          color: @text;
          border-color: @darkest @lightest @lightest @darkest;
          box-shadow: inset -1px -1px 0px rgba(255, 255, 255, 0.1), inset 1px 1px 0px rgba(0, 0, 0, 0.3);
        }
  
        #workspaces button.occupied {
          background-image: linear-gradient(@text, @text);
          background-repeat: no-repeat;
          background-size: 4px 4px;
          background-position: top left;
        }
  
        #battery {
          margin-right: 16px;
        }
  
        #clock {
            margin: 2px 1px 2px 16px;
            padding: 4px 8px;
            border-radius: 0;
            background-color: @base;
            color: @text;
            border: 1px solid;
            border-color: @lightest @darkest @darkest @lightest;
            box-shadow: inset 1px 1px 0px rgba(255, 255, 255, 0.1), inset -1px -1px 0px rgba(0, 0, 0, 0.3);
            font-weight: normal;
        }
  
        @keyframes warnBlink {
          from {
            color: @text;
          }
          to {
            color: #e8e8e8;
          }
        }
  
        /* Battery level colors */
        #battery.warning {
          animation-name: warnBlink;
          animation-duration: 0.1s;
          animation-timing-function: linear;
          animation-iteration-count: infinite;
          animation-direction: alternate;
        }
  
        @keyframes critBlink {
          from {
            color: @text;
          }
          to {
            color: #ff0000;
          }
        }
  
        #battery.critical {
          animation-name: critBlink;
          animation-duration: 0.1s;
          animation-timing-function: linear;
          animation-iteration-count: infinite;
          animation-direction: alternate;
        }
  
        /* Network disconnected */
        #network.disconnected {
            color: @text;
        }
  
        /* Temperature warning */
        #temperature.critical {
            color: #cc4444;
        }
      '';
    };
  };
}
