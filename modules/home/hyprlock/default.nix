{
  lib,
  config,
  pkgs,
  inputs,
  ...
}: {
  options.modules.hyprlock.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.hyprlock.enable {

		home.file.".config/assets/lockscreen.png" = {
      source = ../../../assets/lockscreen.png;
    };

    programs.hyprlock = {
      enable = true;

			settings = {
        general = {
          hide_cursor = true;
          grace = 0;
        };

				auth = {
					"pam:enabled" = true;
				};

        background = {
          #color = "rgba(0, 0, 0, 0.2)";
          blur_passes = 2;
          brightness = 0.2;
					#path = "screenshot";
					path = "$HOME/.config/assets/lockscreen.png";
        };

        label = {
          text = "LOCKED";
          color = "rgba(200, 50, 50, 1.0)";
          font_size = 50;
          font_family = "Departure Mono";
          position = "0, 150";
          halign = "center";
          valign = "center";
        };

        input-field = {
          size = "50, 50";
          dots_size = 0.33;
          dots_spacing = 0.15;
          outer_color = "rgba(25, 20, 20, 0)";
          inner_color = "rgba(25, 20, 20, 0)";
          font_color = "rgba(222, 222, 222, 1.0)";
        };
      };
    };
  };
}
