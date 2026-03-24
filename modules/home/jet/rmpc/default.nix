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
    };

    programs.beets = {
      enable = true;
      # https://github.com/arximboldi/dotfiles/blob/42f44ae499356120957b375146c1325b60703914/nix/os/common/desktop.nix#L103
      package = let
        beetcamp = (pkgs.python3Packages.buildPythonApplication {
          pname = "beets-beetcamp";
          version = "0.21.0";
          src = pkgs.fetchFromGitHub {
            repo = "beetcamp";
            owner = "snejus";
            rev = "64c7afc9d87682fb2b7c9f2deb76525e44afb248";
            sha256 = "sha256-d0yvOyfxPPBUpoO6HCWfMq2vVw+CcQo16hx+JRDMkBw=";
          };
          format = "pyproject";
          buildInputs = with pkgs.python3Packages; [ poetry-core ];
          propagatedBuildInputs = with pkgs.python3Packages; [
            setuptools
            requests
            cached-property
            pycountry
            python-dateutil
            ordered-set
          ];
          checkInputs = with pkgs.python3Packages;
            [
              # pytestCheckHook
              pytest-cov
              pytest-randomly
              pytest-lazy-fixture
              rich
              tox
              types-setuptools
              types-requests
            ] ++ [ pkgs.beets ];
          meta = {
            homepage = "https://github.com/snejus/beetcamp";
            description = "Bandcamp autotagger plugin for beets.";
            license = pkgs.lib.licenses.gpl2;
            inherit (pkgs.beets.meta) platforms;
            maintainers = with pkgs.lib.maintainers; [ rrix ];
          };
        });
      in pkgs.python3.pkgs.beets.override {
        pluginOverrides = {
          beetcamp = {
            enable = true;
            propagatedBuildInputs = [ beetcamp ];
          };
          fetchart.enable = true;
          fromfilename.enable = true;
          chroma.enable = true;
        };
      };

      settings = {
        directory = "/home/alex/Music/library";
        plugins = [ "mpdupdate" "beetcamp" "chroma" "discogs" "lastgenre" "fromfilename" "fetchart" "embedart"];
      
        sources = [ "discogs" "musicbrainz" ];

        discogs = {
          user_token_path = "~/.config/beets/discogs_token";
        };

        fetchart = {
          auto = true;
        };
        embedart = {
          auto = true;
        };

        fromfilename = {
          bin = true;
        };

        match = {
          strong_rec_thresh = 0.25;
        };

        import = {
          group_albums = true;
          singletons = true;
          from_filename = true;
          copy = true;
          quiet_fallback = "skip";
        };
      };
    };
  };
}



