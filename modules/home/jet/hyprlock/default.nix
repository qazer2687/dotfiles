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
          # Doesn't work with GPU accel.
          screencopy_mode = 1;
          hide_cursor = true;
        };

        animations.enable = true;
        animation = [
          "fade, 0, 0, default"
          "inputField, 1, 5, default"
        ];

        background = {
          path = "";
          color = "rgba(35, 38, 52, 1)"; # Frappe Crust
          blur_passes = 0;
          brightness = 0;
        };

        label = {
          text = "LOCKED";
          color = "rgba(202, 158, 230, 1)"; # Frappe Mauve
          font_size = 80;
          font_family = "TX02";
          position = "0, 0";
          halign = "center";
          valign = "center";
        };

        "input-field" = {
          size = "920, 72";
          outline_thickness = 0;
          dots_size = 0.4;
          font_family = "TX02";
          dots_text_format = "X";
          dots_spacing = 0.8;
          dots_center = true;
          outer_color = "rgba(202, 158, 230, 1)";  # Frappe Mauve
          inner_color = "rgba(48, 52, 70, 1)"; # Frappe Base
          font_color = "rgba(198, 208, 245, 1)"; # Frappe Text
          fade_on_empty = false;
          placeholder_text = "";
          hide_input = false;
          rounding = 12;

          # success / fail colors
          fail_color = "rgba(231, 130, 132, 1)";  # Frappe Red
          fail_text = "TRY AGAIN";

          position = "0, -150";
          halign = "center";
          valign = "center";
        };
      };
    };
  };
}
