{
  lib,
  config,
  pkgs,
  inputs,
  ...
}: {
  options.modules..enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules..enable {
    
  };
}
