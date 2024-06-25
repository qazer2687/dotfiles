{
  lib,
  config,
  pkgs,
  ...
}: {
  options.modules.homebrew.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.homebrew.enable {
    homebrew = {
      enable = true;
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
