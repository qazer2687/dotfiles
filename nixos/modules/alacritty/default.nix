{
  lib,
  config,
  pkgs,
  ...
}: {
  options.modules.alacritty.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.alacritty.enable {
    environment.systemPackages = with pkgs; [
      alacritty
    ];
    environment.etc."xdg/alacritty/alacritty.toml".text = ''
      [env]
      TERM = "xterm-256color"

      [window]
      dynamic_padding = false
      opacity = 1
      title = "Alacritty"

      [window.padding]
      x = 10
      y = 10

      [window.class]
      instance = "Alacritty"
      general = "Alacritty"

      [scrolling]
      history = 100_000

      [font]
      size = 10

      [font.normal]
      family = "FiraCode Nerd Font"
      style = "Regular"

      [font.bold]
      family = "FiraCode Nerd Font"
      style = "Bold"

      [font.italic]
      family = "FiraCode Nerd Font"
      style = "Italic"

      [font.bold_italic]
      family = "FiraCode Nerd Font"
      style = "Bold Italic"

      [font.offset]
      x = 0
      y = 0

      [colors.primary]
      background = "#000000"
      foreground = "#CAD3F5"
      dim_foreground = "#CAD3F5"
      bright_foreground = "#CAD3F5"

      [colors.cursor]
      text = "#24273A"
      cursor = "#F4DBD6"

      [colors.vi_mode_cursor]
      text = "#24273A"
      cursor = "#B7BDF8"

      [colors.search.matches]
      foreground = "#24273A"
      background = "#A5ADCB"

      [colors.search.focused_match]
      foreground = "#24273A"
      background = "#A6DA95"

      [colors.hints.start]
      foreground = "#24273A"
      background = "#EED49F"

      [colors.hints.end]
      foreground = "#24273A"
      background = "#A5ADCB"

      [colors.selection]
      text = "#24273A"
      background = "#F4DBD6"

      [colors.normal]
      black = "#494D64"
      red = "#ED8796"
      green = "#A6DA95"
      yellow = "#EED49F"
      blue = "#8AADF4"
      magenta = "#F5BDE6"
      cyan = "#8BD5CA"
      white = "#B8C0E0"

      [colors.bright]
      black = "#5B6078"
      red = "#ED8796"
      green = "#A6DA95"
      yellow = "#EED49F"
      blue = "#8AADF4"
      magenta = "#F5BDE6"
      cyan = "#8BD5CA"
      white = "#A5ADCB"

      [colors.dim]
      black = "#494D64"
      red = "#ED8796"
      green = "#A6DA95"
      yellow = "#EED49F"
      blue = "#8AADF4"
      magenta = "#F5BDE6"
      cyan = "#8BD5CA"
      white = "#B8C0E0"
    '';
  };
}