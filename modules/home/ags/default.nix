{
  lib,
  config,
  pkgs,
  inputs,
  ...
}: {
  options.modules.ags.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.ags.enable {
    programs.ags = {
      enable = true;
    
      configDir = ../config;
    };
  };
}
