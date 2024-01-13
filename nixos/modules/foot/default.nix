{
  lib,
  config,
  pkgs,
  ...
}: {
  options.modules.foot.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.foot.enable {
    environment.systemPackages = with pkgs; [
      foot
    ];
    environment.etc."xdg/foot/foot.ini".text = ''
      font=FiraCode Nerd Font:size=12
      font-bold=FiraCode Nerd Font:size=12
      pad=16x16
      [environment]
      [bell]
      [scrollback]
      lines=100000
      [url]
      [cursor]
      style=beam
      blink=yes
      [mouse]
      hide-when-typing=no
      [touch]
      [colors]
      foreground=ffffff # Text
      background=000000 # Base
      regular0=494d64   # Surface 1
      regular1=ed8796   # red
      regular2=a6da95   # green
      regular3=eed49f   # yellow
      regular4=8aadf4   # blue
      regular5=f5bde6   # pink
      regular6=8bd5ca   # teal
      regular7=b8c0e0   # Subtext 1
      bright0=5b6078    # Surface 2
      bright1=ed8796    # red
      bright2=a6da95    # green
      bright3=eed49f    # yellow
      bright4=8aadf4    # blue
      bright5=f5bde6    # pink
      bright6=8bd5ca    # teal
      bright7=a5adcb    # Subtext 0
      [csd]
      [key-bindings]
      [search-bindings]
      [url-bindings]
      [text-bindings]
      [mouse-bindings]
    '';
  };
}