{
  lib,
  config,
  pkgs,
  inputs,
  ...
}: {
  options.modules.hyprsunset.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.hyprsunset.enable {
    services.hyprsunset = {
      enable = true;
    };
  };
}