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
        * {
            border: none;
            border-radius: 0;
            min-height: 0;
            font-family: "iosevka nerd font";
            font-weight: 500;
            font-size: 14px;
            padding: 0;
        }
        
        window#waybar {
            background: #1d2021;
            border: 2px solid #3c3836;
        }
        
        tooltip {
            background-color: #1d2021;
            border: 2px solid #7c6f64;
        }
        
        #clock,
        #tray,
        #cpu,
        #memory,
        #battery,
        #network,
        #pulseaudio {
            margin: 6px 6px 6px 0px;
            padding: 2px 8px;
        }
        
        #workspaces {
            background-color: #303536;
            margin: 6px 0px 6px 6px;
            border: 2px solid #434a4c;
        }
        
        #workspaces button {
            all: initial;
            min-width: 0;
            box-shadow: inset 0 -3px transparent;
            padding: 2px 4px;
            color: #c7ab7a;
        }
        
        #workspaces button.focused {
            color: #ddc7a1;
        }
        
        #workspaces button.urgent {
            background-color: #e78a4e;
        }
        
        #clock {
            background-color: #303536;
            border: 2px solid #434a4c;
            color: #d4be98;
        }
        
        #tray {
            background-color: #d4be98;
            border: 2px solid #c7ab7a;
        }
        
        #battery {
            background-color: #a9b665;
            border: 2px solid #c7ab7a;
            color: #6c782e;
        }
        
        #cpu,
        #memory,
        #network,
        #pulseaudio {
            background-color: #ddc7a1;
            border: 2px solid #c7ab7a;
            color: #1d2021;
        }
        
        #cpu.critical,
        #memory.critical {
            background-color: #ddc7a1;
            border: 2px solid #c7ab7a;
            color: #c14a4a;
        }
        
        #battery.warning,
        #battery.critical,
        #battery.urgent {
            background-color: #ddc7a1;
            border: 2px solid #c7ab7a;
            color: #c14a4a;
        }
      '';
    };
  };
}
