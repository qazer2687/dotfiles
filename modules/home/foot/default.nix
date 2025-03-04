{
  lib,
  config,
  ...
}: {
  options.modules.foot.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.foot.enable {
    programs.foot = {
      enable = true;
      # This option starts foot as a service and opens clients on demand, I
      # ran into read-only issues when trying this and it's speed feels
      # basically the same as having the setting off, so it doesn't matter.
      server.enable = true;
      settings = {
        main = {
          font = "PragmataPro:size=14, FiraCode Nerd Font:size=14, Noto Color Emoji:size=8";
          font-bold = "PragmataPro:size=14:style=Bold, FiraCode Nerd Font:size=14, Noto Color Emoji:size=8";
          line-height = "22px";
          pad = "16x16";
        };

        scrollback = {
          lines = "10000";
        };

        cursor = {
          style = "beam";
          blink = "yes";
        };

        mouse = {
          hide-when-typing = "no";
        };

        colors = {
          # oxocarbon theme
          #alpha = "0.8"; # Transparency
          foreground = "ffffff"; # base06 white
          background = "161616"; # base01 black

          regular0 = "262626"; # black
          regular1 = "ff7eb6"; # magenta
          regular2 = "42be65"; # green
          regular3 = "ffe97b"; # yellow
          regular4 = "33b1ff"; # blue
          regular5 = "ee5396"; # red
          regular6 = "3ddbd9"; # cyan
          regular7 = "dde1e6"; # white

          bright0 = "393939"; # black
          bright1 = "ff7eb6"; # magenta
          bright2 = "42be65"; # green
          bright3 = "ffe97b"; # yellow
          bright4 = "33b1ff"; # blue
          bright5 = "ee5396"; # red
          bright6 = "3ddbd9"; # cyan
          bright7 = "ffffff"; # white
        };

        key-bindings = {
          clipboard-copy = "Control+c XF86Copy";
          clipboard-paste = "Control+v XF86Paste";
        };
      };
    };
  };
}
