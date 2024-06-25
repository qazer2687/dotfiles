{
  lib,
  config,
  pkgs,
  ...
}: {
  options.modules.yabai.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.yabai.enable {
    services.yabai = {
      enable = true;
      package = pkgs.yabai;
      enableScriptingAddition = true;
      config = {
        window_shadow = "off";
        window_border = "off";

        layout = "bsp";
        top_padding = 6;
        bottom_padding = 6;
        left_padding = 6;
        right_padding = 6;
        window_gap = 6;

        focus_follows_mouse = "autofocus";

        auto_balance = "on";
        split_ratio = 0.5;
      };
    };
  };
}
