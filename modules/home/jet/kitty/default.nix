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
        padding = "8 8";
        # line_height not directly convertible; kitty uses a multiplier.
        # Omitting lets kitty use its default (around 1.0). If you need
        # a specific height, set e.g. line_height = 1.2.

        # Scrollback
        scrollback_lines = 10000;

        # Cursor
        cursor_shape = "beam";
        cursor_blink_interval = 0.5;   # matches foot’s `blink = yes`

        # Mouse
        hide_mouse_when_typing = false;

        # Colors – base16 “oxocarbon-dark” mapped to kitty’s options
        foreground = scheme.base05;
        background = scheme.base00;

        cursor = scheme.base00;
        cursor_text_color = scheme.base06;

        selection_foreground = scheme.base05;
        selection_background = scheme.base01;

        url_color = scheme.base0D;

        # Standard 16 ANSI colors
        color0  = scheme.base03;  # regular0
        color1  = scheme.base08;  # regular1
        color2  = scheme.base0B;  # regular2
        color3  = scheme.base0A;  # regular3
        color4  = scheme.base0D;  # regular4
        color5  = scheme.base0E;  # regular5
        color6  = scheme.base0C;  # regular6
        color7  = scheme.base04;  # regular7

        color8  = scheme.base02;  # bright0
        color9  = scheme.base08;  # bright1
        color10 = scheme.base0B;  # bright2
        color11 = scheme.base0A;  # bright3
        color12 = scheme.base0D;  # bright4
        color13 = scheme.base0E;  # bright5
        color14 = scheme.base0C;  # bright6
        color15 = scheme.base07;  # bright7

        # Extended colors (16 and 17)
        color16 = scheme.base09;
        color17 = scheme.base06;
      };

      keybindings = {
        "ctrl+c"      = "copy_to_clipboard";
        "ctrl+v"      = "paste_from_clipboard";
        "XF86Copy"    = "copy_to_clipboard";
        "XF86Paste"   = "paste_from_clipboard";
      };
    };
  };
}