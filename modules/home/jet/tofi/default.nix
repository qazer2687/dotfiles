{
  lib,
  config,
  pkgs,
  base16,
  ...
}: let
  scheme = base16 "gruvbox";
in {
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
        prompt-text = "‌‌ run:‌‌‌ ‌‌ ‌ ";
        prompt-padding = 0;
        font = "TX02";
        outline-width = 0;
        hint-font = false;
        border-width = 0;
        
        # Catppuccin Macchiato
        input-color = "#${scheme.base05}";
        selection-color = "#${scheme.base05}";
        text-color = "#${scheme.base05}";
        background-color = "#${scheme.base00}";


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
