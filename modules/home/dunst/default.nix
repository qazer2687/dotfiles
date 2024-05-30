{
  lib,
  config,
  pkgs,
  ...
}: {
  options.modules.dunst.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.dunst.enable {
    # ! reports a configuration error (l14,l15) but works fine
    services.dunst = {
      enable = true;
      package = pkgs.dunst;
      settings = {
        global = {
          monitor = "0";
          follow = "mouse";
          width = "400";
          height = "400";
          origin = "top-right";
          offset = "10x60";
          frame_color = "#000000";
          separator_color = "frame";
          progress_bar = "true";
          progress_bar_height = "14";
          progress_bar_frame_width = "1";
          progress_bar_min_width = "150";
          progress_bar_max_width = "300";
          indicate_hidden = "no";
          shrink = "no";
          transparency = "0";
          separator_height = "4";
          notification_limit = "8";
          padding = "16";
          horizontal_padding = "16";
          frame_width = "0";
          sort = "no";
          idle_threshold = "0";
          font = "FiraCode Nerd Font 11";
          line_height = "0";
          markup = "full";
          format = "<b>%s</b>\n%b";
          alignment = "left";
          vertical_alignment = "center";
          show_age_threshold = "120";
          word_wrap = "yes";
          icon_corner_radius = "10";
          ignore_newline = "no";
          stack_duplicates = "false";
          show_indicators = "no";
          icon_position = "left";
          min_icon_size = "60";
          max_icon_size = "60";
          sticky_history = "true";
          history_length = "1";
          dmenu = "/usr/bin/dmenu -p dunst:";
          browser = "/usr/bin/firefox -new-tab";
          always_run_script = "false";
          title = "Dunst";
          class = "Dunst";
          corner_radius = "4";
          ignore_dbusclose = "false";
          force_xinerama = "false";
          mouse_left_click = "close_current";
          mouse_middle_click = "do_action, close_current";
          mouse_right_click = "close_all";
        };

        experimental = {
          per_monitor_dpi = "false";
        };

        urgency_low = {
          background = "#000000";
          foreground = "#ffffff";
          timeout = "8";
        };

        urgency_normal = {
          background = "#000000";
          foreground = "#ffffff";
          timeout = "8";
        };

        urgency_critical = {
          background = "#000000";
          foreground = "#ffffff";
          frame_color = "#FAB387";
          timeout = "0";
        };
      };
    };
  };
}
