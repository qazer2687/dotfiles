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
        };
      };
    };

    services.mpd-mpris = {
      enable = true;
    };

    programs.rmpc = {
      enable = true;
      config = ''
        #![enable(implicit_some)]
        #![enable(unwrap_newtypes)]
        #![enable(unwrap_variant_newtypes)]
        (
            address: "insert your mpd address here",
            theme: "custom",
            cava: (
                input: (
                    method: Fifo,
                    source: "/tmp/mpd.fifo",
                    sample_rate: 44100,
                    channels: 2,
                    sample_bits: 16,
                ),
            ),
            tabs: [
                (
                    name: "Queue",
                    pane: Split(
                        direction: Horizontal,
                        panes: [
                            (size: "60%", pane: Split(
                                direction: Vertical,
                                borders: "RIGHT",
                                panes: [
                                    (size: "50%", pane: Pane(Directories)),
                                    (size: "50%", pane: Pane(Queue), borders: "TOP"),
                                ],
                            )),
                            (size: "40%", pane: Split(
                                direction: Vertical,
                                panes: [
                                    (size: "80%", pane: Pane(AlbumArt)),
                                    (size: "20%", pane: Pane(Cava)),
                                ],
                            )),
                        ],
                    ),
                ),
                (name: "Playlists", pane: Pane(Playlists)),
                (name: "Artists",   pane: Pane(Artists)),
                (name: "Albums",    pane: Pane(Albums)),
                (name: "Search",    pane: Pane(Search)),
            ],
        )
      '';
    };

    xdg.configFile."rmpc/themes/custom.ron".source = ./config/theme.ron;

    programs.beets = {
      enable = true;
      package = pkgs.python3.withPackages (ps: [
        ps.beets
        ps.beetcamp
      ]);

      settings = {
        directory = "/home/alex/Music/library";
        plugins = [ "mpdupdate" "bandcamp" "chroma" "discogs" "lastgenre" "fromfilename" "fetchart" "embedart" "musicbrainz" ];
      
        sources = [ "bandcamp" "musicbrainz" "discogs" ];

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
          strong_rec_thresh = 0.2;
          ignored_fields = [ "track" "index" ];
        };

        import = {
          from_filename = true;
          copy = true;
          quiet_fallback = "skip";
        };
      };
    };
  };
}



