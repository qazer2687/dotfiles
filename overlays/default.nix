# This file defines overlays
_: {
  # This one brings our custom packages from the 'packages' directory
  additions = final: _prev: import ../packages final.pkgs;

  # This one contains whatever you want to overlay
  # You can change versions, add patches, set compilation flags, anything really.
  # https://nixos.wiki/wiki/Overlays
  modifications = _final: _prev: {
    # example = prev.example.overrideAttrs (oldAttrs: rec {
    # ...
    # });

    hyprland = prev.hyprland.override {
      #? Use the legacy renderer for support with Asahi Linux.
      legacyRenderer = true;
    };
  };
}
