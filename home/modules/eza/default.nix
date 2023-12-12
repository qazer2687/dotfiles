{
  lib,
  config,
  pkgs,
  ...
}: {
  options.homeModules.eza.enable = lib.mkEnableOption "";

  config = lib.mkIf config.homeModules.eza.enable {
    programs.eza = {
      enable = true;
      enableAliases = true;
      icons = true;
    };
  };
}

