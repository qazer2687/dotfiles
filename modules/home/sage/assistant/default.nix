{
  lib,
  config,
  pkgs,
  ...
}: let
  venvLibraryPath = lib.makeLibraryPath [
    pkgs.stdenv.cc.cc.lib
    pkgs.zlib
    pkgs.openssl
  ];

  ttsUrl = "http://127.0.0.1:9880";
  ttsRefAudio = "/home/alex/Projects/assistant/tts.ogg";
  ttsPromptFile = "/home/alex/Projects/assistant/prompt.txt";
  ttsTextLang = "en";
  ttsPromptLang = "en";

  assistantSpeak = pkgs.writeShellApplication {
    name = "assistant-speak";
    runtimeInputs = [
      pkgs.curl
      pkgs.coreutils
      pkgs.pipewire
    ];

    text = ''
      text="$1"

      out="$(mktemp --suffix=.wav)"
      trap 'rm -f "$out"' EXIT

      prompt_text="$(cat "${ttsPromptFile}" 2>/dev/null || true)"

      if curl -fsS --max-time 30 -G "${ttsUrl}/tts" \
        --data-urlencode "text=$text" \
        --data-urlencode "text_lang=${ttsTextLang}" \
        --data-urlencode "ref_audio_path=${ttsRefAudio}" \
        --data-urlencode "prompt_text=$prompt_text" \
        --data-urlencode "prompt_lang=${ttsPromptLang}" \
        --data-urlencode "text_split_method=cut0" \
        --data-urlencode "fragment_interval=0" \
        --data-urlencode "media_type=wav" \
        --data-urlencode "streaming_mode=false" \
        -o "$out"; then
        if [ -s "$out" ]; then
          pw-play "$out" || true
        fi
      fi
    '';
  };

  assistantNotify = pkgs.writeShellApplication {
    name = "assistant-notify";
    runtimeInputs = [
      pkgs.coreutils
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

      pkill -f 'assistant-speak' 2>/dev/null || true
      setsid "${assistantSpeak}/bin/assistant-speak" "$body" >/dev/null 2>&1 < /dev/null &
    '';
  };
in {
  options.modules.assistant.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.assistant.enable {
    services.mako.settings."on-notify" = "exec ${assistantNotify}/bin/assistant-notify $id";

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
  };
}
