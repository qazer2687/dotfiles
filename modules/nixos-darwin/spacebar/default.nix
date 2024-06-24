{
  lib,
  config,
  pkgs,
  ...
}: {
  options.modules.spacebar.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.spacebar.enable {
    services.spacebar = {
      enable = true;
      package = pkgs.spacebar;
      config = {
        position = "top";
        display = "main";
        height = 32;
        title = "off";
        spaces = "on";
        clock = "on";
        power = "off";
        padding_left = 20;
        padding_right = 20;
        spacing_left = 25;
        spacing_right = 15;
        text_font = "Menlo:Regular:12.0";
        icon_font = "Font Awesome 5 Free:Solid:12.0";
        background_color = "0xff000000";
        foreground_color = "0xffffff";
        space_icon_color = "0xffffab91";
        space_icon_color_secondary = "0xff78c4d4";
        space_icon_color_tertiary = "0xfffff9b0";
        space_icon_strip = "1 2 3 4 5 6 7 8 9 10";
        spaces_for_all_displays = "on";
        clock_format = "%HH:%mm";
      };
    };
  };
}
