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
          # font = "PragmataPro:size=14, FiraCode Nerd Font:size=14, Noto Color Emoji:size=8";
          # font-bold = "PragmataPro:size=14:style=Bold, FiraCode Nerd Font:size=14, Noto Color Emoji:size=8";
          font = "DepartureMono:size=16.5, FiraCode Nerd Font:size=16.5, Noto Color Emoji:size=10";
          font-bold = "DepartureMono:size=16.5:style=Bold, FiraCode Nerd Font:size=16.5, Noto Color Emoji:size=8";
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
          color = "11111b f5e0dc";
        };
        mouse = {
          hide-when-typing = "no";
        };
        colors = {
          # Gruvbox Dark
          # alpha = "0.8"; # Transparency
          background = "282828";
          foreground = "ebdbb2";

          regular0 = "282828";
          regular1 = "cc241d";
          regular2 = "98971a";
          regular3 = "d79921";
          regular4 = "458588";
          regular5 = "b16286";
          regular6 = "689d6a";
          regular7 = "a89984";

          bright0 = "928374";
          bright1 = "fb4934";
          bright2 = "b8bb26";
          bright3 = "fabd2f";
          bright4 = "83a598";
          bright5 = "d3869b";
          bright6 = "8ec07c";
          bright7 = "ebdbb2";
        };
        key-bindings = {
          clipboard-copy = "Control+c XF86Copy";
          clipboard-paste = "Control+v XF86Paste";
        };
      };
    };
  };
}
