{
  lib,
  config,
  ...
}: {
  options.modules.hyprlock.enable = lib.mkEnableOption "";
  
  config = lib.mkIf config.modules.hyprlock.enable {
    security.pam.services.hyprlock = {};
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

        background = {
          path = "";
          color = "rgba(48, 52, 70, 0.95)"; # Frappe Base
          blur_passes = 6;
          brightness = 0;
        };

        label = {
          text = "LOCKED";
          color = "rgba(202, 158, 230, 1.0)"; # Frappe Mauve
          font_size = 90;
          font_family = "Departure Mono";
          position = "0, 0";
          halign = "center";
          valign = "center";
        };

        "input-field" = {
          size = "920, 72";
          outline_thickness = 2;
          dots_size = 0.45;
          font_family = "Departure Mono";
          dots_text_format = "●";
          dots_spacing = 0.28;
          dots_center = true;
          outer_color = "rgba(41, 44, 60, 0.75)";  # Frappe Mantle
          inner_color = "rgba(48, 52, 70, 0.45)";  # Frappe Base
          font_color = "rgba(198, 208, 245, 1.0)"; # Frappe Text
          fade_on_empty = false;
          placeholder_text = "";
          hide_input = false;

          # success / fail colors
          check_color = "rgba(166, 209, 137, 0.95)"; # Frappe Green
          fail_color = "rgba(231, 130, 132, 0.95)";  # Frappe Red
          fail_text = "TRY AGAIN";

          position = "0, -100";
          halign = "center";
          valign = "center";
        };
      };
    };
  };
}
