{
  lib,
  config,
  base16,
  ...
}: let
  scheme = base16 "framer";
in {
  options.modules.foot.enable = lib.mkEnableOption "";
  config = lib.mkIf config.modules.foot.enable {
    programs.foot = {
      enable = true;
      server.enable = true;
      settings = {
        main = {
          font = "PragmataPro:size=11";
          font-bold = "PragmataPro:size=11:style=Bold";
          line-height = "16px";
          pad = "8x8";
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
          alpha = "1";
          cursor = "${scheme.base00} ${scheme.base06}";
          foreground = scheme.base05;
          background = scheme.base00;

          regular0 = scheme.base03;
          regular1 = scheme.base08;
          regular2 = scheme.base0B;
          regular3 = scheme.base0A;
          regular4 = scheme.base0D;
          regular5 = scheme.base0E;
          regular6 = scheme.base0C;
          regular7 = scheme.base04;

          bright0 = scheme.base02;
          bright1 = scheme.base08;
          bright2 = scheme.base0B;
          bright3 = scheme.base0A;
          bright4 = scheme.base0D;
          bright5 = scheme.base0E;
          bright6 = scheme.base0C;
          bright7 = scheme.base07;

          "16" = scheme.base09;
          "17" = scheme.base06;

          selection-foreground = scheme.base05;
          selection-background = scheme.base01;

          search-box-no-match = "${scheme.base00} ${scheme.base08}";
          search-box-match = "${scheme.base05} ${scheme.base01}";

          jump-labels = "${scheme.base00} ${scheme.base09}";
          urls = scheme.base0D;
        };
        key-bindings = {
          clipboard-copy = "Control+c XF86Copy";
          clipboard-paste = "Control+v XF86Paste";
        };
      };
    };
  };
}
