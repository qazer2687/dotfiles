{
  lib,
  config,
  ...
}: {
  options.modules.vesktop.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.vesktop.enable {
    programs.vesktop = {
      enable = true;
      settings = {
        arRPC = true;
        disableMinSize = true;
        tray = true;
        minimizeToTray = true;
        hardwareAcceleration = true;
        discordBranch = "stable";
      };
      vencord = {
        themes = {
          # Can't use full theme names here as they are overwritten by
          # find and replace when I set a custom base16 scheme.
          mocha = builtins.readFile ./config/mocha.css;
          gruvbox-dark-hard = builtins.readFile ./config/gruvbox-dark-hard.css;
        };
        settings = {
          autoUpdate = true;
          autoUpdateNotification = false;
          notifyAboutUpdates = false;
          useQuickCss = true;
          #enabledThemes = [ "twilight.css" ];
          plugins = {
            MessageLogger = {
              enabled = true;
              ignoreSelf = true;
            };
            FakeNitro.enabled = true;
          };
        };
      };
    };
  };
}
