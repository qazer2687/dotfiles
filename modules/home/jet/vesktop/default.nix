{
  lib,
  config,
  pkgs,
  inputs,
  ...
}: {
  options.modules.vesktop.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.vesktop.enable {
    programs.vesktop = {
      enable = true;
      settings = {
        arRPC = true;
        disableMinSize = true;
        minimizeToTray = false;
        hardwareAcceleration = true;
        discordBranch = "stable";
      };
      vencord = {
        themes = [
          "https://catppuccin.github.io/discord/dist/catppuccin-frappe.theme.css"
        ];
        settings = {
          autoUpdate = true;
          autoUpdateNotification = false;
          notifyAboutUpdates = false;
          useQuickCss = true;
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
