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
          # 16.5px, 11px and 22px are pixel-perfect for Departure Mono.
          font = "DepartureMono:size=11, FiraCode Nerd Font:size=11, Noto Color Emoji:size=10";
          font-bold = "DepartureMono:size=11:style=Bold, FiraCode Nerd Font:size=11, Noto Color Emoji:size=8";
          line-height = "24px";
          pad = "8x8";
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
          # Catppuccin Mocha
          # alpha = "0.8"; # Transparency
          foreground = "cdd6f4";
          background = "1e1e2e";
          regular0 = "45475a";
          regular1 = "f38ba8";
          regular2 = "a6e3a1";
          regular3 = "f9e2af";
          regular4 = "89b4fa";
          regular5 = "f5c2e7";
          regular6 = "94e2d5";
          regular7 = "bac2de";
          bright0 = "585b70";
          bright1 = "f38ba8";
          bright2 = "a6e3a1";
          bright3 = "f9e2af";
          bright4 = "89b4fa";
          bright5 = "f5c2e7";
          bright6 = "94e2d5";
          bright7 = "a6adc8";
          "16" = "fab387";
          "17" = "f5e0dc";
          selection-foreground = "cdd6f4";
          selection-background = "414356";
          search-box-no-match = "11111b f38ba8";
          search-box-match = "cdd6f4 313244";
          jump-labels = "11111b fab387";
          urls = "89b4fa";
          cursor = "11111b f5e0dc";
        };
        key-bindings = {
          clipboard-copy = "Control+c XF86Copy";
          clipboard-paste = "Control+v XF86Paste";
        };
      };
    };
  };
}
