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

    xdg.configFile."rmpc/themes/custom.ron".text = ''
      #![enable(implicit_some)]
      #![enable(unwrap_newtypes)]
      #![enable(unwrap_variant_newtypes)]
      (
          background_color: "#181825",
          text_color: "#dfe1eb",
          tab_bar: (
              enabled: true,
              active_style: (fg: "#181825", bg: "#adacb2", modifiers: "Bold"),
              inactive_style: (),
          ),
          highlighted_item_style: (fg: "#a6adc8", modifiers: "Bold"),
          current_item_style: (fg: "#181825", bg: "#adacb2", modifiers: "Bold"),
          borders_style: (fg: "#a6adc8"),
          highlight_border_style: (fg: "#adacb2"),
          symbols: (
              song: "S",
              dir: " ",
              playlist: "󰲸 ",
              marker: "󰘍  ",
              ellipsis: "...",
          ),
          progress_bar: (
              symbols: ["", "█", "◣", "█", "█"],
              track_style:   (fg: "#1e2030"),
              elapsed_style: (fg: "#a6adc8"),
              thumb_style:   (fg: "#a6adc8", bg: "#1e2030"),
          ),
          cava: (
              bar_symbols: ['▁', '▂', '▃', '▄', '▅', '▆', '▇', '█'],
              bar_width: 2,
              bar_spacing: 1,
              bar_color: Gradient({
                    0: "#45475a",
                  50: "#6c7086",
                  100: "#b4befe",
              })
          ),
          scrollbar: (
              symbols: ["│", "█", "⊤", "⊥"],
              track_style: (),
              ends_style: (),
              thumb_style: (fg: "#a6adc8"),
          ),
          song_table_format: [
              (
                  prop: (kind: Property(Artist), default: (kind: Text("Unknown"))),
                  width: "33%",
              ),
              (
                  prop: (kind: Property(Title), default: (kind: Text("Unknown"))),
                  width: "33%",
                  alignment: Center,
              ),
              (
                  prop: (kind: Property(Duration), default: (kind: Text("-"))),
                  width: "33%",
                  alignment: Right,
              ),
          ],
          layout: Split(
              direction: Vertical,
              panes: [
                  (size: "4",    borders: "ALL", pane: Pane(Header)),
                  (size: "3",                    pane: Pane(Tabs)),
                  (size: "100%", borders: "ALL", pane: Pane(TabContent)),
                  (size: "3",    borders: "ALL", pane: Pane(ProgressBar)),
              ],
          ),
          header: (
              rows: [
                  (
                      left: [
                          (kind: Text("|"),  style: (fg: "#a6adc8", modifiers: "Bold")),
                          (kind: Property(Status(StateV2(playing_label: "Playing", paused_label: "Paused", stopped_label: "Stopped"))), style: (fg: "#a6adc8", modifiers: "Bold")),
                          (kind: Text("|"),  style: (fg: "#a6adc8", modifiers: "Bold")),
                      ],
                      center: [
                          (kind: Property(Song(Title)), style: (modifiers: "Bold"),
                              default: (kind: Text("No Song"), style: (modifiers: "Bold")))
                      ],
                      right: [
                          (kind: Property(Widget(ScanStatus)), style: (fg: "#a6adc8")),
                          (kind: Property(Widget(Volume)),     style: (fg: "#a6adc8")),
                      ]
                  ),
                  (
                      left: [
                          (kind: Property(Status(Elapsed))),
                          (kind: Text(" / ")),
                          (kind: Property(Status(Duration))),
                      ],
                      center: [
                          (kind: Property(Song(Artist)), style: (fg: "#9399b2", modifiers: "Bold"),
                              default: (kind: Text("Unknown"), style: (fg: "#9399b2", modifiers: "Bold"))),
                          (kind: Text(" - ")),
                          (kind: Property(Song(Album)),
                              default: (kind: Text("Unknown Album"))),
                      ],
                      right: [
                          (
                              kind: Property(Widget(States(
                                  active_style: (fg: "white", modifiers: "Bold"),
                                  separator_style: (fg: "white")))),
                              style: (fg: "#9399b2")
                          ),
                      ]
                  ),
              ],
          ),
          browser_song_format: [
              (kind: Group([
                  (kind: Property(Track)),
                  (kind: Text(" ")),
              ])),
              (
                  kind: Group([
                      (kind: Property(Artist)),
                      (kind: Text(" - ")),
                      (kind: Property(Title)),
                  ]),
                  default: (kind: Property(Filename))
              ),
          ],
          lyrics: (timestamp: false)
      )
    '';

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



