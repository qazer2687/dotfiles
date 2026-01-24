{
  lib,
  config,
  ...
}: {
  options.modules.mangohud.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.mangohud.enable {
    programs.mangohud = {
      enable = true;
      # Enabling this options sometimes results in mangohud appearing
      # on launchers or appearing twice on emulated programs.
      enableSessionWide = false;
      settings = {
        toggle_fps_limit = "F1";
        legacy_layout = false;
        gpu_stats = true;
        gpu_temp = true;
        gpu_text = "GPU";
        cpu_stats = true;
        cpu_temp = true;
        cpu_color = "FFFFFF";
        cpu_text = "CPU";
        io_color = "a491d3";
        vram_color = "ad64c1";
        ram_color = "c26693";
        fps = true;
        engine_color = "FFFFFF";
        gpu_color = "FFFFFF";
        wine_color = "FFFFFF";
        frame_timing = 0;
        frametime_color = "FFFFFF";
        media_player_color = "ffffff";
        background_alpha = 0.5;
        font_size = 19;

        background_color = "000000";
        position = "top-left";
        text_color = "ffffff";
        round_corners = 4;
        toggle_hud = "Shift_R+F12";
        toggle_logging = "Shift_L+F2";
        upload_log = "F5";
        output_folder = "/home/alex";
        media_player_name = "spotify";
      };
    };
  };
}
