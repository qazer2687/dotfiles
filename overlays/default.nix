# This file defines overlays
_: {
  # This one brings our custom packages from the 'packages' directory
  additions = final: _prev: import ../packages final.pkgs;

  # This one contains whatever you want to overlay
  # You can change versions, add patches, set compilation flags, anything really.
  # https://nixos.wiki/wiki/Overlays
  modifications = _final: prev: {
    # example = prev.example.overrideAttrs (oldAttrs: rec {
    # ...
    # });

    # Use an older version of mesa with support for scanout on /dev/dri/renderD128 for niri.
    mesa = prev.mesa.override {
      version = "24.2.0";
    };

    ffmpeg-full = prev.ffmpeg-full.override {
      withFullDeps = true;
    };
  };
}
