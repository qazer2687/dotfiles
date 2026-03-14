{
  lib,
  config,
  base16,
  ...
}: let
  scheme = base16 "framer";
in {
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

        authentication = {
          pam.enable = true;
        };

        animations.enable = true;
        animation = [
          "fade, 0, 0, default"
          "inputField, 0, 5, default"
        ];

        background = {
          #path = "/home/alex/.config/wallpaper/wallpaper.png";
          color = "rgba(${scheme.base00}ff)";
        };

        "input-field" = {
          size = "720, 72";
          outline_thickness = 0;
          dots_size = 0.6;
          font_family = "PragmataPro";
          dots_text_format = "×";
          dots_spacing = 0.6;
          dots_center = true;
          outer_color = "rgba(${scheme.base05}00)";
          inner_color = "rgba(${scheme.base01}00)";
          font_color = "rgba(${scheme.base05}ff)";
          fade_on_empty = false;
          placeholder_text = "";
          hide_input = false;
          rounding = 6;

          check_color = "rgba(${scheme.base01}ff)";
          fail_color = "rgba(${scheme.base01}ff)";
          fail_text = "";

          position = "0, 0";
          halign = "center";
          valign = "center";
        };
      };
    };
  };
}
