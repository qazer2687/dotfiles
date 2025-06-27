{
  lib,
  config,
  osConfig,
  ...
}: {
  options.modules.zed.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.zed.enable {
    programs.zed-editor = {
      enable = true;
      # Install remote server on mica only.
      installRemoteServer = osConfig.networking.hostName == "mica";
    };

    home.shellAliases = {
      "zed" = "zeditor";
    };
  };
}
