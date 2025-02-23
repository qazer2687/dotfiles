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
          position = "0, 80";
          halign = "center";
          valign = "center";
        };

        input-field = {
					font_color = "rgba(200, 50, 50, 1.0)";
					font_family = "Departure Mono";
					dots_text_format = "X";
					swap_font_color = "false";
          size = "10000, 10000";
					outline_thickness = 0;
					check_color = "rgb(0,0,0)";
					placeholder_text = "";
					rounding = 2;
          dots_size = 0.0000001;
          dots_spacing = 0.15;
          outer_color = "rgb(0, 0, 0)";
          inner_color = "rgb(0, 0, 0)";
        };
      };
    };
  };
}
