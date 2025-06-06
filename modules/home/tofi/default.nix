{
  lib,
  config,
  pkgs,
  inputs,
  ...
}: {
  options.modules.tofi.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.tofi.enable {
    programs.tofi = {
      enable = true;
      settings = {
        anchor = "bottom";
        width = "100%";
        height = 30;
        horizontal = true;
        font-size = 14;
        prompt-text = " run: ";
        font = "${pkgs.departure-mono}";
        outline-width = 0;
        border-width = 0;
        background-color = "#000000";
        min-input-width = 120;
        result-spacing = 15;
        padding-top = 0;
        padding-bottom = 0;
        padding-left = 0;
        padding-right = 0;
      };
    };
  };
}
