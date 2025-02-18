{
  lib,
  config,
  pkgs,
  inputs,
  ...
}: {
  options.modules.mpd.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.mpd.enable {

    programs.ncmpcpp = {
      enable = true;
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
