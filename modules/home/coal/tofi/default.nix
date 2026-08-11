{
  lib,
  config,
  ...
}: {
  options.modules.tofi.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.tofi.enable {
    programs.tofi = {
      enable = true;
      settings = {
        anchor = "top";
        width = "100%";
        height = 20;
        clip-to-padding = false;
        horizontal = true;
        font-size = 14;
        prompt-text = " run:  ";
        font = "Terminus Bold";
        outline-width = 0;
        border-width = 0;
        background-color = "#000000";
        text-color = "#aaaaaa";
        selection-color = "#000000";
        selection-background = "#aaaaaa";
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
