{
  lib,
  config,
  pkgs,
  ...
}: {
  options.modules.bat.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.bat.enable {
    programs.bat = {
      enable = true;
    };
    home.shellAliases = {
      "cat" = "bat";
    };
  };
}
