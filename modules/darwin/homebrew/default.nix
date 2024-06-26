{
  lib,
  config,
  ...
}: {
  options.modules.homebrew.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.homebrew.enable {
    homebrew = {
      enable = true;

      onActivation = {
        autoUpdate = true;
        upgrade = true;
        cleanup = "zap";
      };

      taps = [
        "homebrew/core"
        "homebrew/cask"
        "qazer2687/tap"
      ];

      brews = [
      ];

      casks = [
        "alacritty"
        "firefox"
        "vscodium"
        "obsidian"
        "vlc"
        "hiddenbar" # to replace vanilla because it has a startup window
        "spaceid"

        # custom
        "qazer2687/tap/armcord"

        # experimental
        "zed"
      ];
    };
  };
}
