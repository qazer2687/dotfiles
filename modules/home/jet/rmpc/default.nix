{
  lib,
  config,
  pkgs,
  inputs,
  ...
}: {
  options.modules.rmpc.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.rmpc.enable {
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
      '';
    };

    services.mpd-discord-rpc = {
      enable = true;
    };

    services.mpd-mpris = {
      enable = true;
    };

    programs.rmpc = {
      enable = true;
    };

    programs.beets = {
      enable = true;
      package = (pkgs.beets.override { pluginOverrides = { chroma.enable = false; }; }) ;
      
      settings = {
        directory = "/home/alex/Music/library";
        plugins = [ "chroma" "from_filename" ];
      
        import = {
          write = true;
          move = true;
          copy = false;
          autotag = true;
          singletons = true; 
        };
      };
    };
  };
}



