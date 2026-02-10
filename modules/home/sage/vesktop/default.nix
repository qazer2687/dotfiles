{
  lib,
  config,
  ...
}: {
  options.modules.vesktop.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.vesktop.enable {
    services.arrpc.enable = true;

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
          amoled-cord = builtins.readFile ./config/amoled-cord.css;
        };
        settings = {
          autoUpdate = true;
          autoUpdateNotification = false;
          notifyAboutUpdates = false;
          useQuickCss = true;
          enabledThemes = ["amoled-cord.css"];
          plugins = {
            MessageLogger = {
              enabled = true;
              ignoreSelf = true;
            };
            FakeNitro.enabled = true;
            SpotifyCrack.enabled = true;
            AnonymiseFileNames.enabled = true;
            BiggerStreamPreview.enabled = true;
            CallTimer.enabled = true;
            ClearURLs.enabled = true;
            FixImagesQuality.enabled = true;
            ForceOwnerCrown.enabled = true;
            GameActivityToggle.enabled = true;
            ImageFilename.enabled = true;
            ImplicitRelationships.enabled = true;
            MemberCount.enabled = true;
            Experiments.enabled = true;
            FriendsSince.enabled = true;
            PinDMs.enabled = true;
            ShikiCodeblocks.enabled = true;
            SilentTyping.enabled = true;
            YoutubeAdblock.enabled = true;
          };
        };
      };
    };
  };
}
