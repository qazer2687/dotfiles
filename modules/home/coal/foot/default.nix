{
  lib,
  config,
  pkgs,
  ...
}: {
  options.modules.foot.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.foot.enable {
    programs.foot = {
      enable = true;
      settings = {
        main = {
          font = "Terminus:weight=bold:size=16";
          dpi-aware = "no";
        };
        colors = {
          background = "000000";
        };
        key-bindings = {
          clipboard-copy = "Control+c";
          clipboard-paste = "Control+v";
        };
        text-bindings = {
          "\\x03" = "Control+Shift+c";
        };
      };
    };
  };
}
