{
  lib,
  config,
  pkgs,
  inputs,
  ...
}: {
  options.modules.rngd.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.rngd.enable {
    security.rngd = {
      enable = true;
    };
  };
}
