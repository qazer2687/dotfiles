{
  lib,
  config,
  pkgs,
  inputs,
  ...
}: {
  options.modules.rmpc.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.rmpc.enable {


    home.packages = [ pkgs.chromaprint pkgs.mpc];

    services.mpd = {
      enable = true;
      musicDirectory = "/home/alex/Music/library";
      extraConfig = ''
        audio_output {
          type            "pulse"
          name            "pulse"
          mixer_type      "hardware"
          mixer_device    "default"
          mixer_control   "PCM"
          mixer_index     "0"
        }
        filesystem_charset "UTF-8"
      '';
    };

    services.mpd-discord-rpc = {
      enable = true;
      settings = {
        format = {
          small_image = "";
        }
      };
    };

    services.mpd-mpris = {
      enable = true;
    };

    programs.rmpc = {
      enable = true;
    };

    programs.beets = {
      enable = true;
      package = (pkgs.python3Packages.beets.override { pluginOverrides = { chroma.enable = true; }; }) ;
      
      settings = {
        directory = "/home/alex/Music/library";
        plugins = [ "chroma" "discogs" "lastgenre" "fromfilename" "fetchart" "embedart"];
      
        discogs = {
          user_token_path = "~/.config/beets/discogs_token";
        };

        fetchart = {
          auto = true;
        };
        embedart = {
          auto = true;
        };

        match = {
          # 75%
          strong_rec_thresh = 0.35;
        };

        import = {
          copy = true;
          quiet_fallback = "skip";
        };
      };
    };
  };
}



