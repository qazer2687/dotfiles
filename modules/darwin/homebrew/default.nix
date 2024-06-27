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
        "fastfetch"
      ];

      casks = [
        # GUI Applications
        "alacritty"
        "firefox"
        "vscodium"
        "obsidian"
        "vlc"
        # "hiddenbar"
        "spaceid"

        # Custom
        "qazer2687/homebrew-tap/armcord"

        # Experimental
        "zed"
      ];
    };
  };
}
