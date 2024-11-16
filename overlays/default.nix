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

    hyprland = prev.hyprland.override {
      # Use the legacy renderer for support with Asahi Linux.
      #legacyRenderer = true;
    };

    zed-editor = prev.zed-editor.override {
      # zed-editor withGLES false (might work without as of the new asahi updates 15/11/24, hyprland works when it didn't before)
    };

    dwl = (prev.dwl.overrideAttrs (oldAttrs: rec {
      patches = [
        ../patches/dwl/autostart.patch
        ../patches/dwl/vanitygaps.patch
        ../patches/dwl/movestack.patch
        ../patches/dwl/push.patch
      ];
    })).override{ configH = ../modules/home/dwl/config/config.h; };
  };
}
