{
  lib,
  config,
  ...
}: {
  options.modules.hyprlock.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.hyprlock.enable {
    programs.hyprlock = {
      enable = true;

      settings = {
        general = {
          immediate_render = true;
          disable_loading_bar = true;
          hide_cursor = true;
        };

        auth = {
          "pam:enabled" = true;
        };

        # BACKGROUND
        background = {
          path = "";
          color = "rgba(17, 17, 27, 1.0)";
          blur_passes = 2;
          brightness = 0;
        };

        label = {
          text = "LOCKED";
          color = "rgba(203, 166, 247, 1.0)";
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
          font_color = "rgba(205, 214, 244, 1.0)";
          fade_on_empty = false;
          placeholder_text = "";
          hide_input = false;
          check_color = "rgba(0, 0, 0, 0)";
          fail_color = "rgba(0, 0, 0, 0)";
          fail_text = "TRY AGAIN";
          position = "0, -100";
          halign = "center";
          valign = "center";
        };
      };
    };
  };
}
