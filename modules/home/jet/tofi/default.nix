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
        height = "22";
        scale = true;
        horizontal = true;
        font-size = "11";
        prompt-text = "‌‌ run:‌‌ ";
        prompt-padding = 0;
        font = "${pkgs.departure-mono}/share/fonts/otf/DepartureMono-Regular.otf";
        outline-width = 0;
        hint-font = false;
        border-width = 0;
        
        # Catppuccin Macchiato
        input-color = "#cad3f5";
        selection-color = "#c6a0f6";
        text-color = "#cad3f5";
        background-color = "#181926";

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
