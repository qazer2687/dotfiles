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

    ffmpeg-full = prev.ffmpeg-full.override {
      withFullDeps = true;
    };

    dwl = prev.dwl.overrideAttrs (_oldAttrs: rec {
      # The order these are listed is the same as
      # the order that the patches are applied.
      patches = [
        ../patches/dwl/vanitygaps-0.7.patch
        #  ../patches/dwl/bar-0.7.patch
        ../patches/dwl/ipc.patch
        # ../patches/dwl/hot-reload-0.7.patch
        ../patches/dwl/autostart-0.7.patch
        # ../patches/dwl/movestack.patch
        # ../patches/dwl/push.patch
      ];
    });
  };
}
