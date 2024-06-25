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

      brews = [
      ];

      casks = [
        "zed"
        "vlc"
        "vanilla"
        "spaceid"
      ];
    };
  };
}
