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
        height = 30;
        horizontal = true;
        font-size = "16.5";
        prompt-text = ''> '';
        font = "${pkgs.departure-mono}/share/fonts/otf/DepartureMono-Regular.otf";
        outline-width = 0;
        border-width = 0;
        background-color = "#000000";
        min-input-width = 160;
        result-spacing = 15;
        padding-top = 0;
        padding-bottom = 0;
        padding-left = 0;
        padding-right = 0;
      };
    };
  };
}
