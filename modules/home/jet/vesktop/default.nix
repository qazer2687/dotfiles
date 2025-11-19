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
          frappe = builtins.readFile ./config/frappe.css;
          gruvbox-dark-hard = builtins.readFile ./config/gruvbox-dark-hard.css;
        };
        settings = {
          autoUpdate = true;
          autoUpdateNotification = false;
          notifyAboutUpdates = false;
          useQuickCss = true;
          enabledThemes = [ "gruvbox-dark-hard.css" ];
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
