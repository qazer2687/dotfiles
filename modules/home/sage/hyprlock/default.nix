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
          screencopy_mode = 0;
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

        "input-field" = {
          size = "720, 72";
          outline_thickness = 0;
          dots_size = 0.4;
          font_family = "Departure Mono";
          dots_text_format = "♦";
          dots_spacing = 1;
          dots_center = true;
          outer_color = "rgba(202, 158, 230, 1)"; # Frappe Mauve
          inner_color = "rgba(48, 52, 70, 1)"; # Frappe Base
          font_color = "rgba(202, 158, 230, 1)"; # Frappe Mauve
          fade_on_empty = false;
          placeholder_text = "";
          hide_input = false;
          rounding = 12;

          check_color = "rgba(48, 52, 70, 1)";
          fail_color = "rgba(48, 52, 70, 1)";
          fail_text = "";

          position = "0, 0";
          halign = "center";
          valign = "center";
        };
      };
    };
  };
}
