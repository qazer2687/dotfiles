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
      settings = [
        {
          margin-top = 10;
          margin-left = 10;
          margin-right = 10;
          layer = "top";
          position = "top";
          output = "DP-1";
    
          modules-left = [
            "custom/start"
            "hyprland/submap"
            "hyprland/workspaces"
            "hyprland/window"
          ];
          modules-right = [
            "tray"
            "temperature"
            "cpu"
            "memory"
            "disk"
            "network"
            "pulseaudio"
            "battery"
            "power-profiles-daemon"
            "clock"
          ];
          "cpu" = {
            states = {
              critical = 85;
            };
            interval = 1;
            format = " {usage:2}%";
            on-click = "kitty btop";
          };
          "memory" = {
            states = {
              critical = 85;
            };
            interval = 1;
            format = " {percentage}%";
            on-click = "kitty btop";
          };
          "disk" = {
            states = {
              critical = 85;
            };
            interval = 5;
            format = " {percentage_used}%";
            on-click = "kitty btop";
          };
          "network" = {
            format-ethernet = " {bandwidthDownOctets}";
            format-wifi = " {signalStrength}%";
            format-disconnected = "";
            format-disabled = "";
            tooltip = false;
            on-click = "rofi-network-manager";
          };
          "temperature" = {
            critical-threshold = 80;
            format = " {temperatureC}°C";
            interval = 1;
            on-click = "kitty btop";
          };
          "power-profiles-daemon" = {
            format = "{icon} {profile}";
            format-icons = {
              performance = "";
              power-saver = "";
              balanced = "";
            };
          };
          "hyprland/workspaces" = {
            format = "{name}";
            format-icons = {
              default = " ";
              active = " ";
              urgent = " ";
            };
            on-scroll-down = "hyprctl dispatch workspace e+1";
            on-scroll-up = "hyprctl dispatch workspace e-1";
          };
          "hyprland/window" = {
            icon = true;
            max-length = 45;
            separate-outputs = false;
            rewrite = {
              "" = "${username}@${hostname}";
              "~" = "${username}@${hostname}";
            };
            on-click-right = "hyprctl dispatch fullscreen 0";
            on-click-middle = "hyprctl dispatch killactive";
            on-click = "hyprctl dispatch fullscreen 1";
          };
          "hyprland/submap" = {
            format = " {}";
            on-click = "hyprctl dispatch submap reset";
          };
          "clock" = {
            format = "{:%b %d, %I:%M %p}";
          };
          "tray" = {
            spacing = 12;
          };
          "taskbar" = {
            icon-size = 10;
            icon-theme = "Papirus-Dark";
            on-click = "activate";
            on-click-right = "fullscreen";
            on-click-middle = "close";
            on-scroll-up = "maximize";
            on-scroll-down = "minimize";
          };
          "pulseaudio" = {
            format = "{icon} {volume}% {format_source}";
            format-bluetooth = "{volume}% {icon} {format_source}";
            format-bluetooth-muted = " {icon} {volume}% {format_source_muted}";
            format-muted = " {volume}% {format_source_muted}";
            format-source = "";
            format-source-muted = "";
            format-icons = {
              headphone = "";
              hands-free = "";
              headset = "";
              phone = "";
              portable = "";
              car = "";
              default = [
                ""
                ""
                ""
              ];
            };
            on-click = "pavucontrol";
            on-click-right = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
          };
          "battery" = {
            states = {
              warning = 30;
              critical = 15;
            };
            format = "{icon} {capacity}%";
            format-charging = " {capacity}%";
            format-plugged = " {capacity}%";
            format-icons = [
              ""
              ""
              ""
              ""
              ""
            ];
            interval = 1;
            on-click = "";
          };
          "custom/start" = {
            format = "";
            on-click-right = "rofi -show power-menu -modi power-menu:rofi-power-menu";
            on-click = "rofi -show drun";
          };
        }
      ];
      style = ''
        * {
          font-size: 12px;
          font-family: Font Awesome, monospace;
          font-weight: bold;
          color: @text;
          transition: none;
        }
    
        window#waybar {
          background: rgba(0,0,0,0);
          border: none;
        }
        
        #workspaces button {
          border-radius: 0px;
          margin: 0px;
          background: none;
          border: none;
        }
    
        #workspaces button:hover, #custom-start:hover, #window:hover {
          border: none;
          outline: none;
          background: none;
          color: @text;
          background-size: 300% 300%;
          background: @surface0;
        }
    
        #workspaces button.active, #submap {
          background: @surface1;
        }
    
        #custom-start {
          padding: 0px 5px;
          color: @sky;
          font-size: 16px;
        }
    
        #window, #submap {
          padding: 0px 5px;
        }
    
        .modules-left, .modules-right {
          background-color: @crust;
          border: 2px solid @surface1;
          border-radius: 10px;
          padding: 0 5px;
        }
        #submap, #workspaces, #cpu, #memory, #disk, #clock, #window, #tray, #pulseaudio, #battery, #network, #temperature, #power-profiles-daemon, #custom-exit, #custom-start {
          margin: 0 5px;
        }
        .critical, .muted, .performance {
          color: @red;
        }
        .warning, .urgent {
          color: @yellow;
        }
        .charging, .plugged, .power-saver {
          color: @green;
        }
      '';
    };
  };
}
