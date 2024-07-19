{
  lib,
  config,
  pkgs,
  ...
}: {
  options.modules.bat.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.bat.enable {
    programs.eza = {
      enable = true;
    };
    home.shellAliases = {
      "ls" = "eza --colour=always --icons=always --all";
    };
  };
}
