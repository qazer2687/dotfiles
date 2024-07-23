{
  lib,
  config,
  ...
}: {
  options.modules.foot.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.foot.enable {
    programs.foot = {
      enable = true;
      server.enable = true; # open foot with the footclient command
      settings = {
        font = "Agave:size=12, FiraCode Nerd Font:size=12";
        font-bold = "Agave:size=12:style=Bold, FiraCode Nerd Font:size=12";
        pad = "16x16";

        scrollback = {
          lines = "1000";
        };

        cursor = {
          style = "beam";
          blink = "yes";
        };

        mouse = {
          hide_when_typing = "no";
        };

        colors = {
          foreground = "#ffffff";
          background = "#000000";
          color0 = "#494d64";
          color1 = "#ed8796";
          color2 = "#a6da95";
          color3 = "#eed49f";
          color4 = "#8aadf4";
          color5 = "#f5bde6";
          color6 = "#8bd5ca";
          color7 = "#b8c0e0";
          color8 = "#5b6078";
          color9 = "#ed8796";
          color10 = "#a6da95";
          color11 = "#eed49f";
          color12 = "#8aadf4";
          color13 = "#f5bde6";
          color14 = "#8bd5ca";
          color15 = "#a5adcb";
        };
      };
    };
  };
}
