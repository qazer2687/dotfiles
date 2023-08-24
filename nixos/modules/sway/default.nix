{
  lib,
  config,
  pkgs,
  ...
}: {
  options.systemModules.sway.ruby.enable = lib.mkEnableOption "";
  # Configuration
  config = lib.mkIf config.systemModules.sway.ruby.enable {
    programs.sway = {
      enable = true;
    };
  };
}