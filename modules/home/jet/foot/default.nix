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
          font = "TX02:size=14, FiraCode Nerd Font:size=14";
          font-bold = "TX02:size=14:style=Bold, FiraCode Nerd Font:size=14";
          line-height = "22px";
          pad = "10x10"; 
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
          # Catppuccin Frappe
          cursor = "232634 f2d5cf";
          foreground = "c6d0f5";
          background = "303446";

          regular0 = "51576d";
          regular1 = "e78284";
          regular2 = "a6d189";
          regular3 = "e5c890";
          regular4 = "8caaee";
          regular5 = "f4b8e4";
          regular6 = "81c8be";
          regular7 = "b5bfe2";

          bright0 = "626880";
          bright1 = "e78284";
          bright2 = "a6d189";
          bright3 = "e5c890";
          bright4 = "8caaee";
          bright5 = "f4b8e4";
          bright6 = "81c8be";
          bright7 = "a5adce";

          "16" = "ef9f76";
          "17" = "f2d5cf";

          selection-foreground = "c6d0f5";
          selection-background = "4f5369";

          search-box-no-match = "232634 e78284";
          search-box-match = "c6d0f5 414559";

          jump-labels = "232634 ef9f76";
          urls = "8caaee";
        };
        key-bindings = {
          clipboard-copy = "Control+c XF86Copy";
          clipboard-paste = "Control+v XF86Paste";
        };
      };
    };
  };
}
