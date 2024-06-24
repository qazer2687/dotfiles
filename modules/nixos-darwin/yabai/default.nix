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

        ## leave space for spacebar (not needed)
        ##external_bar = "all:26:0";

        ## make menu bar invisible
        menubar_opacity = 0.0;

        window_topmost = "off";
        window_shadow = "off";
        window_border = "off";
        title = "on";
        title_font_size = 0;

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

        auto_balance = "on";
        split_ratio = 0.5;
      };
    };
  };
}
