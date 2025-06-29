{
  lib,
  config,
  pkgs,
  ...
}: {
  options.modules.tofi.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.tofi.enable {
    programs.tofi = {
      enable = true;
      settings = {
        anchor = "bottom";
        width = "100%";
        height = "33";
        scale = false;
        horizontal = true;
        font-size = "22";
        prompt-text = "‌‌ run:‌‌ ";
        prompt-padding = 0;
        font = "${pkgs.departure-mono}/share/fonts/otf/DepartureMono-Regular.otf";
        outline-width = 0;
        hint-font = true;
        border-width = 0;
        input-color = "#cdd6f4";
        selection-color = "#cba6f7";
        text-color = "#cdd6f4";
        background-color = "#11111b";
        min-input-width = 100;
        result-spacing = 15;
        padding-top = 0;
        padding-bottom = 0;
        padding-left = 0;
        padding-right = 0;
      };
    };
  };
}
