{
  lib,
  config,
  ...
}: {
  options.modules.foot.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.foot.enable {
    programs.foot = {
      enable = true;
      ## This option starts foot as a service and opens clients on demand, I
      ## ran into read-only issues when trying this and it's speed feels
      ## basically the same as having the setting off, so it doesn't matter.
      server.enable = false;
      settings = {
        main = {
          font = "Agave:size=12, FiraCode Nerd Font:size=12";
          font-bold = "Agave:size=12:style=Bold, FiraCode Nerd Font:size=12";
          pad = "16x16";
        };

        scrollback = {
          lines = "1000";
        };

        cursor = {
          style = "beam";
          blink = "yes";
        };

        mouse = {
          hide-when-typing = "no";
        };

        colors = {
          foreground = "ffffff"; # Text
          background = "000000"; # Base
          regular0 = "494d64"; # Surface 1
          regular1 = "ed8796"; # red
          regular2 = "a6da95"; # green
          regular3 = "eed49f"; # yellow
          regular4 = "8aadf4"; # blue
          regular5 = "f5bde6"; # pink
          regular6 = "8bd5ca"; # teal
          regular7 = "b8c0e0"; # Subtext 1
          bright0 = "5b6078"; # Surface 2
          bright1 = "ed8796"; # red
          bright2 = "a6da95"; # green
          bright3 = "eed49f"; # yellow
          bright4 = "8aadf4"; # blue
          bright5 = "f5bde6"; # pink
          bright6 = "8bd5ca"; # teal
          bright7 = "a5adcb"; # Subtext 0
        };

        key-bindings = {
          clipboard-copy = "Control+c XF86Copy";
          clipboard-paste = "Control+v XF86Paste";
        };
      };
    };
  };
}
