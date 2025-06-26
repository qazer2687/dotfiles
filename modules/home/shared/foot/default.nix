{
  lib,
  config,
  ...
}: {
  options.modules.foot.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.foot.enable {
    programs.foot = {
      enable = true;
      server.enable = true;
      settings = {
        main = {
          #font = "PragmataPro:size=14, FiraCode Nerd Font:size=14, Noto Color Emoji:size=8";
          #font-bold = "PragmataPro:size=14:style=Bold, FiraCode Nerd Font:size=14, Noto Color Emoji:size=8";
          font = "DepartureMono:size=14, FiraCode Nerd Font:size=14, Noto Color Emoji:size=8";
          font-bold = "DepartureMono:size=14:style=Bold, FiraCode Nerd Font:size=14, Noto Color Emoji:size=8";
          line-height = "22px";
          pad = "16x16";
        };

        scrollback = {
          # I don't really need that much scrollback,
          # I think it just wastes a bit more memory.
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
          # oxocarbon
          #alpha = "0.8"; # Transparency
          foreground = "ffffff"; # base06 white
          background = "000000"; # base01 black

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
