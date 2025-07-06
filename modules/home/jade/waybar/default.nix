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
          layer = "top";
          output = "DP-1";
          position = "top";
          margin-top = 10;
          margin-left = 10;
          margin-right = 10;
          
          modules-left = [
            "custom/start"
            "hyprland/submap"
            "hyprland/workspaces"
            "hyprland/window"
            "clock"
          ];
          modules-center = [];
          modules-right = [
            "tray"
            "temperature"
            "cpu"
            "mpris"
            "memory"
            "pulseaudio"
            "disk"
            "network"
            "battery"
            "power-profiles-daemon"
          ];
    
          pulseaudio = {
            tooltip = false;
            scroll-step = 1;
            on-click = "pavucontrol";
            on-click-right = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
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
              default = ["" "" ""];
            };
          };
    
          clock = {
            format = "{:%A %d, %H:%M}";
            tooltip = false;
          };
    
          battery = {
            format = "{icon} {capacity}%";
            format-charging = " {capacity}%";
            format-plugged = " {capacity}%";
            format-icons = ["" "" "" "" ""];
            full-at = 95;
            format-full = "󱟢";
            tooltip = true;
            tooltip-format = "{capacity}%";
            states = {
              warning = 30;
              critical = 15;
            };
            interval = 1;
          };
    
          "hyprland/workspaces" = {
            format = "{name}";
            format-icons = {
              "1" = "1";
              "2" = "2";
              "3" = "3";
              "4" = "4";
              "5" = "5";
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
            on-click-right = "hyprctl dispatch fullscreen 0";
            on-click-middle = "hyprctl dispatch killactive";
            on-click = "hyprctl dispatch fullscreen 1";
          };
    
          "hyprland/submap" = {
            format = " {}";
            on-click = "hyprctl dispatch submap reset";
          };
    
          mpris = {
            tooltip = false;
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
            format-wifi = " {signalStrength}%";
            format-disconnected = "";
            format-alt = "{ipaddr}";
            format-ethernet = " {bandwidthDownOctets}";
            format-disabled = "";
            interval = 2;
            on-click = "rofi-network-manager";
          };
    
          memory = {
            tooltip = true;
            format = " {percentage}%";
            tooltip-format = "{percentage}%";
            interval = 1;
            states = {
              critical = 85;
            };
            on-click = "kitty btop";
          };
    
          cpu = {
            states = {
              critical = 85;
            };
            interval = 1;
            format = " {usage:2}%";
            on-click = "kitty btop";
          };
    
          backlight = {
            device = "intel_backlight";
            tooltip = true;
            format = "{icon}";
            tooltip-format = "{percent}%";
            format-icons = ["󰃞" "󰃟" "󰃠"];
          };
    
          temperature = {
            tooltip = false;
            thermal-zone = 5;
            critical-threshold = 80;
            format = " {temperatureC}°C";
            format-critical = " {temperatureC}°C";
            interval = 1;
            on-click = "kitty btop";
          };
    
          disk = {
            tooltip = true;
            format = " {percentage_used}%";
            tooltip-format = "{percentage_used}%";
            interval = 5;
            states = {
              critical = 85;
            };
            on-click = "kitty btop";
          };
    
          tray = {
            spacing = 12;
          };
    
          "power-profiles-daemon" = {
            format = "{icon} {profile}";
            format-icons = {
              performance = "";
              power-saver = "";
              balanced = "";
            };
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
          font-family: "Departure Mono", "FiraCode Mono Nerd Font", Font Awesome, monospace;
          font-size: 12px;
          font-weight: bold;
          background-color: transparent;
          border-radius: 0px;
          margin-left: 2px;
          margin-right: 2px;
          color: @text;
          transition: none;
        }
    
        window#waybar {
          background: rgba(0,0,0,0);
          border: none;
        }
    
        #workspaces {
          background-color: transparent;
        }
    
        #workspaces button {
          padding: 3px 18px;
          margin-top: 6px;
          margin-bottom: 6px;
          margin-left: 3px;
          margin-right: 3px;
          border-radius: 5px;
          background-color: #262626;
          color: #ffffff;
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
          color: #000000;
          background-color: #ffffff;
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
    
        #submap, #workspaces, #cpu, #memory, #disk, #clock, #window, #tray, #pulseaudio, #battery, #network, #temperature, #power-profiles-daemon, #custom-start {
          margin: 0 5px;
        }
    
        #memory,
        #custom-power,
        #battery,
        #backlight,
        #pulseaudio,
        #network,
        #clock,
        #cpu,
        #temperature,
        #disk,
        #tray {
          border-radius: 5px;
          margin-top: 6px;
          margin-bottom: 6px;
          margin-left: 3px;
          margin-right: 3px;
          padding: 6px 12px;
          color: #ffffff;
          background-color: #000000;
        }
    
        #mpris {
          padding: 3px 18px;
          margin-top: 6px;
          margin-bottom: 6px;
          margin-left: 3px;
          margin-right: 3px;
          border-radius: 5px;
          color: #000000;
          background-color: #ffffff;
        }
    
        #battery {
          background-color: #ffffff;
          color: #000000;
        }
    
        #battery.warning,
        #battery.critical,
        #battery.urgent {
          background-color: #cc0000;
          color: #000000;
          animation-name: blink;
          animation-duration: 0.5s;
          animation-timing-function: linear;
          animation-iteration-count: infinite;
          animation-direction: alternate;
        }
    
        #battery.charging {
          background-color: #00cc00;
          color: #000000;
        }
    
        #network {
          padding-right: 17px;
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
    
        tooltip {
          border-radius: 8px;
          padding: 15px;
          background-color: #131822;
        }
    
        tooltip label {
          padding: 5px;
          background-color: #131822;
        }
      '';
    };
  };
}
