{
  lib,
  config,
  pkgs,
  ...
}: let
  petImage = ../../../../assets/nozomi.png;

  venvLibraryPath = lib.makeLibraryPath [
    pkgs.stdenv.cc.cc.lib
    pkgs.zlib
    pkgs.openssl
  ];

  ttsUrl = "http://127.0.0.1:9880";
  translateUrl = "http://127.0.0.1:9881";
  ttsTextLang = "ja";
  ttsRefAudio = "/home/alex/Projects/pet/ref/ref_Lobby_5.wav";
  ttsPromptText = "えー、つまんないことはやりたくないよー？";
  ttsPromptLang = "ja";

  ttsFlourishes = [
    "ふふふっ！"
    "ふふっ！"
    "えへへっ！"
  ];
  flourishesLiteral = lib.concatMapStringsSep " " (s: "\"${s}\"") ttsFlourishes;

  petSpeak = pkgs.writeShellApplication {
    name = "pet-speak";
    runtimeInputs = [
      pkgs.curl
      pkgs.coreutils
      pkgs.eww
      pkgs.jq
      pkgs.pipewire
    ];

    text = ''
      text="$1"

      translated="$(curl -fsS --max-time 20 -G "${translateUrl}/translate" \
        --data-urlencode "text=$text" 2>/dev/null | jq -r '.translation // empty' 2>/dev/null || true)"
      if [ -n "$translated" ]; then
        text="$translated"
      fi

      flourishes=(${flourishesLiteral})
      flourish="''${flourishes[$((RANDOM % ''${#flourishes[@]}))]}"
      case "$text" in
        *[。！？!?]) text="''${text}''${flourish}" ;;
        *) text="''${text}。''${flourish}" ;;
      esac

      out="$(mktemp --suffix=.wav)"
      trap 'rm -f "$out"' EXIT

      linger() {
        sleep 4
      }

      if curl -fsS --max-time 30 -G "${ttsUrl}/tts" \
        --data-urlencode "text=$text" \
        --data-urlencode "text_lang=${ttsTextLang}" \
        --data-urlencode "ref_audio_path=${ttsRefAudio}" \
        --data-urlencode "prompt_text=${ttsPromptText}" \
        --data-urlencode "prompt_lang=${ttsPromptLang}" \
        --data-urlencode "text_split_method=cut0" \
        --data-urlencode "fragment_interval=0" \
        --data-urlencode "media_type=wav" \
        --data-urlencode "streaming_mode=false" \
        -o "$out"; then
        if [ -s "$out" ]; then
          pw-play "$out" || linger
        else
          linger
        fi
      else
        linger
      fi

      sleep 2
      eww close pet || true
    '';
  };

  petNotify = pkgs.writeShellApplication {
    name = "pet-notify";
    runtimeInputs = [
      pkgs.coreutils
      pkgs.eww
      pkgs.jq
      pkgs.mako
      pkgs.procps
      pkgs.util-linux
    ];

    text = ''
      id="''${1:-}"

      list="$(makoctl list -j || true)"

      text=""
      summary=""
      if [ -n "$id" ] && [ -n "$list" ]; then
        text="$(printf '%s' "$list" | jq -r --argjson id "$id" '.[] | select(.id == $id) | .body // ""' || true)"
        summary="$(printf '%s' "$list" | jq -r --argjson id "$id" '.[] | select(.id == $id) | .summary // ""' || true)"
      fi

      body="''${text:-$summary}"
      body="$(printf '%s' "$body" | tr '\n\r\t' '   ' | tr -s ' ' | cut -c1-200 | sed -e 's/^ *//' -e 's/ *$//')"

      if [ -z "$body" ]; then
        exit 0
      fi

      eww open pet || true

      pkill -f 'pet-speak' 2>/dev/null || true
      setsid "${petSpeak}/bin/pet-speak" "$body" >/dev/null 2>&1 < /dev/null &
    '';
  };
in {
  options.modules.pet.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.pet.enable {
    programs.eww = {
      enable = true;
      package = pkgs.eww;

      yuckConfig = ''
        (defwindow pet
          :monitor 0
          :geometry (geometry :x "40px" :y "40px"
                              :width "200px" :height "385px"
                              :anchor "bottom right")
          :stacking "overlay"
          :exclusive false
          :focusable "none"
          :namespace "pet"
          (image :path "${petImage}"
                 :image-width 200
                 :image-height 385
                 :preserve-aspect-ratio true))
      '';

      scssConfig = ''
        .pet { background: transparent; }
      '';

      systemd.enable = true;
    };

    services.mako.settings."on-notify" = "exec ${petNotify}/bin/pet-notify $id";

    systemd.user.services.gpt-sovits = {
      Unit = {
        Description = "GPT-SoVITS text-to-speech API server";
        ConditionPathExists = "%h/Projects/pet/.venv/bin/python";
        After = ["network.target"];
      };
      Service = {
        Type = "simple";
        WorkingDirectory = "%h/Projects/pet/GPT-SoVITS";
        Environment = [
          "LD_LIBRARY_PATH=${venvLibraryPath}:${pkgs.ffmpeg.lib}/lib"
        ];
        ExecStart = "%h/Projects/pet/.venv/bin/python api_v2.py -a 127.0.0.1 -p 9880";
        Restart = "on-failure";
        RestartSec = 5;
      };
      Install = {
        WantedBy = ["default.target"];
      };
    };

    systemd.user.services.pet-translate = {
      Unit = {
        Description = "Local English->Japanese translation server (NLLB)";
        ConditionPathExists = "%h/Projects/pet/translate_server.py";
        After = ["network.target"];
      };
      Service = {
        Type = "simple";
        WorkingDirectory = "%h/Projects/pet";
        Environment = [
          "LD_LIBRARY_PATH=${venvLibraryPath}"
          "HF_HOME=%h/.cache/huggingface"
        ];
        ExecStart = "%h/Projects/pet/.venv/bin/python translate_server.py";
        Restart = "on-failure";
        RestartSec = 5;
      };
      Install = {
        WantedBy = ["default.target"];
      };
    };
  };
}
