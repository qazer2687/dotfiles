{
  lib,
  config,
  ...
}: {
  options.homeModules.services.spotifyd.enable = lib.mkEnableOption "";

  config = lib.mkIf config.homeModules.services.spotifyd.enable {
    # Installation
    services.spotifyd = {
      enable = true;
      settings = {
        global = {
          username = "3fl3wvehzpuudbzovifsyndbp";
          password_cmd = "$HOME/.config/spotifyd/read_password.sh";
          use_keyring = false;
          use_mpris = true;
          dbus_type = "session";
          backend = "pipewire";
          device = "default";
          audio_format = "S16";
          mixer = "PCM";
          volume_controller = "alsa";
          device_name = "SpotifyD";
          bitrate = 320;
          cache_path = "/home/alex/.cache/spotifyd";
          max_cache_size = 5000000000;
          no_audio_cache = false;
          initial_volume = "60";
          volume_normalisation = false;
          normalisation_pregain = -10;
          autoplay = true;
          device_type = "speaker";
        };
      }
    };

    # Configuration
    #xdg.configFile."spotifyd/spotifyd.conf".text = builtins.readFile ./spotifyd.conf;
    xdg.configFile."spotifyd/read_password.sh".text = builtins.readFile ./read_password.sh;
    xdg.configFile."spotifyd/read_password.sh".executable = true;
  };
}
