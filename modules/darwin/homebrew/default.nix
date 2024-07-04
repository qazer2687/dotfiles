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
        "qazer2687/homebrew-tap"
      ];

      brews = [
        # CLI Programs
        # Managed by HM...
      ];

      casks = [
        # GUI Applications - Not indexed by spotlight search when using Nix, so this is required.

        ## General
        "firefox"
        "vscodium"
        "obsidian"
        "vlc"
        "tor-browser"
        "spaceid"
        "discord"

        ## Games
        "osu"

        ## Custom
        "qazer2687/homebrew-tap/armcord"
      ];
    };
  };
}
