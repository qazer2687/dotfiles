{
  lib,
  config,
  osConfig,
  pkgs,
  ...
}: {
  options.modules.zed.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.zed.enable {
    programs.zed-editor = {
      enable = true;
      package = pkgs.zed-editor-fhs;
      installRemoteServer = (osConfig.networking.hostName == "mica");
    };

    home.shellAliases = {
      "zed" = "zeditor";
    };
  };
}
