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
        # GUI Applications - Not indexed by spotlight search when using Nix, so this is required.

        # Generafl
        "firefox"
        "vscodium"
        "obsidian"
        "spaceid"
        "calibre"
        "microsoft-teams"

        # Virtualization
        "utm"

        # Custom
        "qazer2687/homebrew-tap/vesktop"

        # Experimental
        "zed"
        "wireshark"
      ];
    };
  };
}
