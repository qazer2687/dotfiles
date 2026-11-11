{
  lib,
  config,
  pkgs,
  ...
}: {
  options.modules.hypridle.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.hypridle.enable {
    # Dim overlay used by hypridle: a bare hyprlock with only a translucent
    # black background (no widgets). Dismissed by killing the process.
    xdg.configFile."hypr/hyprlock-dim.conf".text = ''
      general {
        immediate_render = true
        hide_cursor = true
      }

      animations {
        enabled = false
      }

      background {
        # alpha cc = 80% black overlay; tweak for dim strength
        color = rgba(000000cc)
      }
    '';

    services.hypridle = {
      enable = true;
      settings = {
        listener = [
          {
            timeout = 240;
            on-timeout = ''${pkgs.hyprlock}/bin/hyprlock --config $HOME/.config/hypr/hyprlock-dim.conf'';
            on-resume = ''pkill -f hyprlock-dim.conf'';
          }
          {
            timeout = 480;
            on-timeout = ''hyprctl eval "hl.dsp.dpms('off')"'';
            on-resume = ''hyprctl eval "hl.dsp.dpms('on')"'';
          }
        ];
      };
    };
  };
}
