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
        top_padding = 8;
        bottom_padding = 8;
        left_padding = 8;
        right_padding = 8;
        window_gap = 8;

        focus_follows_mouse = "autofocus";

        auto_balance = "on";
        split_ratio = 0.5;
      };
    };
  };
}
