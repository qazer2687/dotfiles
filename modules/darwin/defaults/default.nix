{
  lib,
  config,
  ...
}: {
  options.modules.defaults.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.defaults.enable {
    system.defaults = {
      NSGlobalDomain = {
        AppleShowAllExtensions = true;
        AppleShowAllFiles = true;
        _HIHideMenuBar = false;
        "com.apple.swipescrolldirection" = false;
      };
      finder = {
        ShowStatusBar = false;
      };
      dock = {
        autohide = true;
        autohide-delay = 1000.0;
        mru-spaces = false;
      };
    };
  };
}
