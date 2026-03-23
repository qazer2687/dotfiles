{
  lib,
  config,
  base16,
  ...
}: let
  scheme = base16 "oxocarbon-dark";
in {
  options.modules.kitty.enable = lib.mkEnableOption "";
  config = lib.mkIf config.modules.kitty.enable {
    programs.kitty = {
      enable = true;

      settings = {
        # Font
        font_family = "PragmataPro";
        font_size = 11;
        bold_font = "PragmataPro";

        # Layout
        padding = "16 16";

        # Scrollback
        scrollback_lines = 10000;

        # Cursor
        cursor_shape = "beam";
        cursor_blink_interval = 0.5;

        # Mouse
        hide_mouse_when_typing = false;

        # Colors – with "#" prefix
        foreground = "#${scheme.base05}";
        background = "#${scheme.base00}";

        cursor = "#${scheme.base06}";
        cursor_text_color = "#${scheme.base06}";

        selection_foreground = "#${scheme.base05}";
        selection_background = "#${scheme.base01}";

        url_color = "#${scheme.base0D}";

        # Standard 16 ANSI colors
        color0  = "#${scheme.base03}";
        color1  = "#${scheme.base08}";
        color2  = "#${scheme.base0B}";
        color3  = "#${scheme.base0A}";
        color4  = "#${scheme.base0D}";
        color5  = "#${scheme.base0E}";
        color6  = "#${scheme.base0C}";
        color7  = "#${scheme.base04}";

        color8  = "#${scheme.base02}";
        color9  = "#${scheme.base08}";
        color10 = "#${scheme.base0B}";
        color11 = "#${scheme.base0A}";
        color12 = "#${scheme.base0D}";
        color13 = "#${scheme.base0E}";
        color14 = "#${scheme.base0C}";
        color15 = "#${scheme.base07}";

        # Extended colors
        color16 = "#${scheme.base09}";
        color17 = "#${scheme.base06}";
      };

      keybindings = {
        "ctrl+c"    = "copy_to_clipboard";
        "ctrl+v"    = "paste_from_clipboard";
        "XF86Copy"  = "copy_to_clipboard";
        "XF86Paste" = "paste_from_clipboard";
      };
    };
  };
}