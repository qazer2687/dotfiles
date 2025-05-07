{
  lib,
  config,
  pkgs,
  inputs,
  ...
}: {
  options.modules.zed.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.zed.enable {
    programs.zed-editor = {
      enable = true;
    };
    home.shellAliases = {
      "zed" = "zeditor";
    };
  };
}


