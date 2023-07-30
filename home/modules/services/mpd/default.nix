{
  lib,
  config,
  ...
}: {
  options.homeModules.services.mpd.enable = lib.mkEnableOption "";

  config = lib.mkIf config.homeModules.services.mpd.enable {
    services.mpd = {
      enable = false;
      musicDirectory = "/home/alex/Music";
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
  };
}
