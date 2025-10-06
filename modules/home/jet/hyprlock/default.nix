{
  lib,
  config,
  base16,
  ...
}: let
  scheme = base16 "catppuccin-mocha";
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

        animations.enable = true;
        animation = [
          "fade, 0, 0, default"
          "inputField, 1, 5, default"
        ];

        background = {
          path = "";
          color = "rgba(${scheme.base00}ff)"; # Frappe Crust
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
          outer_color = "rgba(${scheme.base05}ff)";
          inner_color = "rgba(${scheme.base01}ff)";
          font_color = "rgba(${scheme.base05}ff)";
          fade_on_empty = false;
          placeholder_text = "";
          hide_input = false;
          rounding = 12;

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
