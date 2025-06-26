{
  lib,
  config,
  ...
}: {
  options.modules.mpd.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.mpd.enable {
    programs.ncmpcpp = {
      enable = true;
      settings = {
        alternative_header_first_line_format = "$5{$b%t$/b}$9";
        alternative_header_second_line_format = "$3by $7{$b%a$/b}$9 $3from $7{$b%b$/b}$9 $5{(%y)}";
        song_list_format = "♫   $2%n$(end) $9 $3%a$(end) $(245)-$9 $(246)%t$9 $R{ $5%y$9}$(end)     $(246)%lq$(end)";
        song_columns_list_format = "(3f)[red]{n} (3f)[246]{} (35)[white]{t} (18)[blue]{a} (30)[green]{b} (5f)[yellow]{d} (5f)[red]{y} (7f)[magenta]{l}";
        song_status_format = "$b $8%A $8•$3• $3%t $3•$5• $5%b $5•$2• $2%y $2•$8• %g (bold)";
        playlist_display_mode = "columns";
        browser_display_mode = "columns";
        search_engine_display_mode = "columns";
        colors_enabled = true;
        empty_tag_color = "red";
        statusbar_color = "blue";
        state_line_color = "black";
        state_flags_color = "default";
        main_window_color = "blue";
        header_window_color = "white";
        alternative_ui_separator_color = "black";
        window_border_color = "green";
        active_window_border = "red";
        volume_color = "default";
        progressbar_color = "black";
        progressbar_elapsed_color = "blue";
        statusbar_time_color = "blue";
        player_state_color = "default";
        display_bitrate = true;
        autocenter_mode = true;
        centered_cursor = true;
        titles_visibility = false;
        enable_window_title = true;
        statusbar_visibility = true;
        empty_tag_marker = "";
        mouse_support = true;
        header_visibility = false;
        display_remaining_time = false;
        ask_before_clearing_playlists = true;
        discard_colors_if_item_is_selected = true;
        user_interface = "alternative";
        default_find_mode = "wrapped";
        lyrics_directory = "~/.lyrics";
        follow_now_playing_lyrics = true;
        store_lyrics_in_song_dir = false;
        ignore_leading_the = true;
        lines_scrolled = 1;
        mouse_list_scroll_whole_page = false;
        show_hidden_files_in_local_browser = false;
        startup_screen = "playlist";
        execute_on_song_change = "~/.bin/np";
        connected_message_on_startup = false;
        playlist_separate_albums = false;
        allow_for_physical_item_deletion = false;
        visualizer_in_stereo = true;
        visualizer_data_source = "/tmp/mpd.fifo";
        visualizer_type = "wave_filled";
        visualizer_look = "▉▋";
        progressbar_look = "━━━";
      };
    };

    services.mpd = {
      enable = true;
      musicDirectory = "/home/alex/music";
      extraConfig = ''
        audio_output {
          type            "pulse"
          name            "pulse"
          mixer_type      "hardware"
          mixer_device    "default"
          mixer_control   "PCM"
          mixer_index     "0"
        }
      '';
    };

    services.mpd-discord-rpc = {
      enable = true;
    };

    services.mpd-mpris = {
      enable = true;
    };
  };
}
