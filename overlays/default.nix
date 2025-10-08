# This file defines overlays
#_: {
{pkgs, _}: {
  # This one brings our custom packages from the 'packages' directory
  additions = final: _prev: import ../packages final.pkgs;

  # This one contains whatever you want to overlay
  # You can change versions, add patches, set compilation flags, anything really.
  # https://nixos.wiki/wiki/Overlays
  modifications = _final: prev: {
    # example = prev.example.overrideAttrs (oldAttrs: rec {
    # ...
    # });

    ffmpeg-full = prev.ffmpeg-full.override {
      withFullDeps = true;
    };

    jetbrains.clion = prev.clion.override {
      buildInputs = prev.buildInputs ++ [ pkgs.gcc pkgs.cmake pkgs.gdb pkgs.ninja ];
    };
  };
}
