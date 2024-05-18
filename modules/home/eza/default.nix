{
  lib,
  config,
  pkgs,
  ...
}: {
  options.modules.eza.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.eza.enable {
    programs.eza = {
      enable = true;
      enableBashIntegration = true;
      icons = true;
    };
  };
}
