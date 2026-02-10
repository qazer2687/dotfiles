{
  lib,
  config,
  base16,
  ...
}: let
  scheme = base16 "kanagawa-dragon";
in {
  options.modules.hyprlock.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.hyprlock.enable {
    programs.hyprlock = {
      enable = true;
      settings = {
        general = {
          immediate_render = true;
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
          path = "/home/alex/.config/wallpaper/wallpaper.png";
          blur_passes = 2;
          brightness = 0.5;

          #color = "rgba(${scheme.base00}ff)";
        };

        "input-field" = {
          size = "720, 72";
          outline_thickness = 0;
          dots_size = 0.4;
          font_family = "PragmataPro";
          dots_text_format = "×";
          dots_spacing = 0.5;
          dots_center = true;
          outer_color = "rgba(${scheme.base05}ff)";
          inner_color = "rgba(${scheme.base01}ff)";
          font_color = "rgba(${scheme.base05}ff)";
          fade_on_empty = false;
          placeholder_text = "";
          hide_input = false;
          rounding = 4;

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
