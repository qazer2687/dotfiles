{
  lib,
  config,
  pkgs,
  self,
  ...
}: {
  options.modules.i3.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.i3.enable {
    home.packages = with self.packages; [
      dmenu
      scrot
      feh
      redshift
      xorg.xkill
    ];

    xsession = {
      enable = true;
      windowManager.i3 = {
        enable = true;
        package = self.packages.i3-rounded;
        config = rec {
          modifier = "Mod4";
          startup = [
            {
              always = true;
              command = "dbus-update-activation-environment --all";
            }
            {
              always = true;
              command = "$HOME/.config/polybar/launch.sh &";
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
            "${modifier}+Return" = "exec --no-startup-id alacritty";
            "${modifier}+space" = "floating toggle";
            "${modifier}+q" = "kill";
            "${modifier}+Shift+q" = "exec --no-startup-id xkill";
            "${modifier}+e" = "exec --no-startup-id dmenu_run -i -b -nb '#000000' -sb '#ffffff' -nf '#ffffff' -sf '#000000' -fn 'FiraCode Nerd Font'";
            "${modifier}+Left" = "move left";
            "${modifier}+Down" = "move down";
            "${modifier}+Up" = "move up";
            "${modifier}+Right" = "move right";
            "${modifier}+Shift+Right" = "resize shrink width 5 px or 5 ppt";
            "${modifier}+Shift+Up" = "resize grow height 5 px or 5 ppt";
            "${modifier}+Shift+Down" = "resize shrink height 5 px or 5 ppt";
            "${modifier}+Shift+Left" = "resize grow width 5 px or 5 ppt";
            "${modifier}+1" = "workspace number 1";
            "${modifier}+2" = "workspace number 2";
            "${modifier}+3" = "workspace number 3";
            "${modifier}+4" = "workspace number 4";
            "${modifier}+5" = "workspace number 5";
            "${modifier}+6" = "workspace number 6";
            "${modifier}+7" = "workspace number 7";
            "${modifier}+8" = "workspace number 8";
            "${modifier}+9" = "workspace number 9";
            "${modifier}+Shift+1" = "move container to workspace number 1";
            "${modifier}+Shift+2" = "move container to workspace number 2";
            "${modifier}+Shift+3" = "move container to workspace number 3";
            "${modifier}+Shift+4" = "move container to workspace number 4";
            "${modifier}+Shift+5" = "move container to workspace number 5";
            "${modifier}+Shift+6" = "move container to workspace number 6";
            "${modifier}+Shift+7" = "move container to workspace number 7";
            "${modifier}+Shift+8" = "move container to workspace number 8";
            "${modifier}+Shift+9" = "move container to workspace number 9";
            "${modifier}+Shift+r" = "restart";
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
    };
  };
}
