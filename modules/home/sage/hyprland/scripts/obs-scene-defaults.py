import json
import os
from pathlib import Path

path = Path(os.environ["OBS_SCENE"])
if not path.exists():
    raise SystemExit(0)

data = json.loads(path.read_text())
changed = False
for key, value in (
    ("DesktopAudioDevice1", os.environ["OBS_SINK_MONITOR"]),
    ("AuxAudioDevice1", os.environ["OBS_SOURCE"]),
):
    source = data.get(key)
    if source is not None and source.get("settings", {}).get("device_id") != value:
        source.setdefault("settings", {})["device_id"] = value
        changed = True

if changed:
    tmp = path.with_suffix(path.suffix + ".tmp")
    tmp.write_text(json.dumps(data, indent=4) + "\n")
    tmp.replace(path)
