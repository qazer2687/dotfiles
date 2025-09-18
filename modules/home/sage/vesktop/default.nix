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
        };
        settings = {
          autoUpdate = true;
          autoUpdateNotification = false;
          notifyAboutUpdates = false;
          useQuickCss = true;
          enabledThemes = ["frappe.css"];
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
