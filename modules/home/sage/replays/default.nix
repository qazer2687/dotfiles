{
  lib,
  config,
  pkgs,
  ...
}: let
  replaysDir = "/home/alex/replays";
  stateFile = "/tmp/replays";

  replays = pkgs.writeShellApplication {
    name = "replays";
    runtimeInputs = [
      pkgs.immich-cli
      pkgs.jq
      pkgs.coreutils
      pkgs.gnused
      pkgs.gawk
    ];

    text = ''
      set -euo pipefail

      STATE="${stateFile}"

      if [ ! -d "${replaysDir}" ]; then
        printf 'err\n%s does not exist\n%s\n' "${replaysDir}" "$(date -Iseconds)" > "$STATE"
        exit 1
      fi

      IMMICH_INSTANCE_URL="$(cat '${config.sops.secrets.immich-server-url.path}')"
      IMMICH_API_KEY="$(cat '${config.sops.secrets.immich-api-key.path}')"
      export IMMICH_INSTANCE_URL IMMICH_API_KEY

      OUT="$(mktemp)"
      ERR="$(mktemp)"
      trap 'rm -f "$OUT" "$ERR"' EXIT

      if immich upload \
        --visibility archive \
        --album-name Replays \
        --recursive \
        --no-progress \
        --json-output \
        "${replaysDir}" > "$OUT" 2> "$ERR"; then
        JSON="$(awk '
          /^{$/ { in_json = 1 }
          in_json {
            depth += gsub(/\{/, "{")
            depth -= gsub(/\}/, "}")
            print
            if (depth == 0) exit
          }
        ' "$OUT")"

        if [ -z "$JSON" ]; then
          printf 'ok\nNo files to upload\n%s\n' "$(date -Iseconds)" > "$STATE"
        else
          NEW="$(printf '%s\n' "$JSON" | jq '.newFiles | length')"
          DUP="$(printf '%s\n' "$JSON" | jq '.duplicates | length')"
          if [ "$NEW" -eq 0 ]; then
            MSG="No new files detected"
          else
            MSG="Synced $NEW new file(s), $DUP duplicate(s) skipped"
          fi
          printf 'ok\n%s\n%s\n' "$MSG" "$(date -Iseconds)" > "$STATE"
        fi
      else
        printf 'err\n%s\n%s\n' "$(tail -n 1 "$ERR")" "$(date -Iseconds)" > "$STATE"
        exit 1
      fi
    '';
  };
in {
  options.modules.replays.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.replays.enable {
    sops.secrets = {
      immich-server-url = {
        sopsFile = ../../../../secrets/homelab/immich.yaml;
        key = "server_url";
      };
      immich-api-key = {
        sopsFile = ../../../../secrets/homelab/immich.yaml;
        key = "api_key";
      };
    };

    systemd.user.services.replays = {
      Unit = {
        Description = "Sync replay captures to Immich";
        After = [ "sops-nix.service" ];
        Wants = [ "sops-nix.service" ];
      };
      Service = {
        Type = "oneshot";
        ExecStart = "${replays}/bin/replays";
      };
    };

    systemd.user.timers.replays = {
      Unit = {
        Description = "Periodic replay sync to Immich";
      };
      Timer = {
        OnBootSec = "2min";
        OnUnitActiveSec = "30min";
        Persistent = true;
      };
      Install = {
        WantedBy = [ "timers.target" ];
      };
    };
  };
}
