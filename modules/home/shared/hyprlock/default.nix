{
  lib,
  config,
  ...
}: {
  options.modules.hyprlock.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.hyprlock.enable {
    home.file.".config/assets/lockscreen.png" = {
      source = ../../../../assets/lockscreen.png;
    };

    programs.hyprlock = {
      enable = true;

      settings = {
        general = {
          disable_loading_bar = true;
          hide_cursor = true;
        };

        auth = {
          "pam:enabled" = true;
        };

        # BACKGROUND
        background = {
          path = "$HOME/.config/assets/lockscreen.png";
          blur_passes = 2;
          brightness = 0;
        };

        # LAYOUT
        /*
        label = {
        	text = "LOCKED";
        	color = "rgba(200, 50, 50, 1.0)";
        	font_size = 25;
        	font_family = "Departure Mono";
        	position = "30, -30";
        	halign = "left";
        	valign = "top";
        };
        */

        # TIME
        /*
        label = {
        	text = "$TIME";
        	color = "rgba(200, 50, 50, 1.0)";
        	font_size = 90;
        	font_family = "Departure Mono";
        	position = "-30, 0";
        	halign = "right";
        	valign = "top";
        };
        */

        label = {
          text = "LOCKED";
          color = "rgba(200, 50, 50, 1.0)";
          font_size = 100;
          font_family = "Departure Mono";
          position = "0, 0";
          halign = "center";
          valign = "center";
        };

        # INPUT FIELD
        input-field = {
          size = "1000, 80";
          outline_thickness = 0;
          dots_size = 0.33;
          font_family = "Departure Mono";
          dots_text_format = "X";
          dots_spacing = 0.2;
          dots_center = true;
          outer_color = "rgba(0, 0, 0, 0)";
          inner_color = "rgba(0, 0, 0, 0)";
          font_color = "rgba(255, 255, 255, 1.0)";
          fade_on_empty = false;
          placeholder_text = "";
          hide_input = false;
          check_color = "rgba(0, 0, 0, 0)";
          fail_color = "rgba(0, 0, 0, 0)";
          fail_text = "KILL YOURSELF";
          position = "0, -100";
          halign = "center";
          valign = "center";
        };
      };
    };
  };
}
