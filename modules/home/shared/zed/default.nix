{
  lib,
  config,
  ...
}: {
  options.modules.zed.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.zed.enable {
    programs.zed-editor = {
      enable = true;
      installRemoteServer = (config.networking.hostName == "mica");
    };

    home.shellAliases = {
      "zed" = "zeditor";
    };
  };
}
