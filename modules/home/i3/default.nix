{
  lib,
  config,
  pkgs,
  ...
}: {
  options.modules.i3.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.i3.enable {
    xsession = {
      enable = true;
      windowManager.i3 = {
        enable = true;
        package = pkgs.i3-rounded;
        config = {
          modifier = "Mod4";
          startup = [
            {
              always = true;
              command = "dbus-update-activation-environment --all";
            }
            {
              always = true;
              command = "gnome-keyring-daemon --start --components=secrets";
            }
            {
              always = true;
              command = "feh --bg-fill /home/alex/.config/wallpaper/wallpaper.png";
            }
            {
              always = true;
              command = "i3-msg workspace number 1";
            }
          ];

          keybindings = {
            "$mod+Return" = "exec --no-startup-id alacritty";
            "$mod+space" = "floating toggle";
            "$mod+q" = "kill";
            "$mod+Shift+q" = "exec --no-startup-id xkill";
            "$mod+e" = "exec --no-startup-id dmenu_run -i -b -nb '#000000' -sb '#ffffff' -nf '#ffffff' -sf '#000000' -fn 'FiraCode Nerd Font'";
            "$mod+Left" = "move left";
            "$mod+Down" = "move down";
            "$mod+Up" = "move up";
            "$mod+Right" = "move right";
            "$mod+Shift+Right" = "resize shrink width 5 px or 5 ppt";
            "$mod+Shift+Up" = "resize grow height 5 px or 5 ppt";
            "$mod+Shift+Down" = "resize shrink height 5 px or 5 ppt";
            "$mod+Shift+Left" = "resize grow width 5 px or 5 ppt";
            "$mod+1" = "workspace number 1";
            "$mod+2" = "workspace number 2";
            "$mod+3" = "workspace number 3";
            "$mod+4" = "workspace number 4";
            "$mod+5" = "workspace number 5";
            "$mod+6" = "workspace number 6";
            "$mod+7" = "workspace number 7";
            "$mod+8" = "workspace number 8";
            "$mod+9" = "workspace number 9";
            "$mod+Shift+1" = "move container to workspace number 1";
            "$mod+Shift+2" = "move container to workspace number 2";
            "$mod+Shift+3" = "move container to workspace number 3";
            "$mod+Shift+4" = "move container to workspace number 4";
            "$mod+Shift+5" = "move container to workspace number 5";
            "$mod+Shift+6" = "move container to workspace number 6";
            "$mod+Shift+7" = "move container to workspace number 7";
            "$mod+Shift+8" = "move container to workspace number 8";
            "$mod+Shift+9" = "move container to workspace number 9";
            "$mod+Shift+r" = "restart";
          };

          gaps = {
            inner = 8;
            outer = 0;
          };

          window = {
            border = 0;
            titlebar = false;
          };

          bars = [
            {
              mode = "invisible";
              hiddenState = "hide";
            }
          ];
        };

        extraConfig = ''
          default_border pixel 0
          border_radius 4
        '';
      };

      home.packages = with pkgs; [
        dmenu
        scrot
        feh
        redshift
        xorg.xkill
      ];
    };
  };
}
