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
        external_bar = "main:32:0";

        mouse_modifier = "cmd";
        mouse_action1 = "move";
        mouse_action2 = "resize";
        mouse_drop_action = "sway";

        layout = "bsp";
        top_padding = 8;
        bottom_padding = 8;
        left_padding = 8;
        right_padding = 8;
        window_gap = 8;

        focus_follows_mouse = "autofocus";
        mouse_follows_focus = "on";

        window_topmost = "on";
        window_shadow = "float";
        window_placement = "second_child";
        window_border = "off";

        auto_balance = "on";
        split_ratio = 0.5;
      };
    };
  };
}
