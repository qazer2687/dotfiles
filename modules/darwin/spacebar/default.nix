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
        power = "on";
        padding_left = 20;
        padding_right = 20;
        spacing_left = 25;
        spacing_right = 15;
        text_font = "FiraCode Mono Nerd Font:Regular:30"; # font size doesn't work
        status_bar_text_font = "FiraCode Mono Nerd Font:Regular:30";
        icon_font = "FiraCode Mono Nerd Font:Regular:30";
        background_color = "0xff000000";
        foreground_color = "0xff888888";
        power_icon_color = "0xffcd950c";
        battery_icon_color = "0xffd75f5f";
        dnd_icon_color = "0xffa8a8a8";
        clock_icon_color = "0xffa8a8a8";
        clock_icon = "⠀"; # blank character to hide clock icon
        power_icon_strip = "";
        space_icon = "";
        space_icon_color = "0xffffffff";
        space_icon_color_secondary = "0xff78c4d4";
        space_icon_color_tertiary = "0xfffff9b0";
        space_icon_strip = "1 2 3 4 5 6 7 8 9 10";
        spaces_for_all_displays = "on";
        clock_format = "%H:%m";
      };
    };
  };
}
