{config, pkgs, ...}:

{
  home-manager.users.alex.xdg.configFile."alacritty/alacritty.yml".text = ''
  env:
    TERM: xterm-256color

  window:
    padding:
      x: 10
      y: 10
    dynamic_padding: false
    opacity: 1.0
    title: Alacritty
    class:
      instance: Alacritty
      general: Alacritty

  scrolling:
    history: 10000

  font:
    normal:
      family: FiraCode Nerd Font
      style: Regular
    bold:
      family: FiraCode Nerd Font
      style: Bold
    italic:
      family: FiraCode Nerd Font
      style: Italic
    bold_italic:
      family: FiraCode Nerd Font
      style: Bold Italic
    size: 10
    offset:
      x: 0
      y: 0

  colors:
    primary:
      background: '0x111111'
      foreground: '0xffffff'
    normal:
      black:   '0x1e2127'
      red:     '0xe06c75'
      green:   '0x98c379'
      yellow:  '0xd19a66'
      blue:    '0x61afef'
      magenta: '0xc678dd'
      cyan:    '0x56b6c2'
      white:   '0x828791'
  '';
}
