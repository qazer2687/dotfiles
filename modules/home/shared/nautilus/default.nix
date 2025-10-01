{
  lib,
  config,
  pkgs,
  inputs,
  ...
}: {
  options.modules.nautilus.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.nautilus.enable {
    home.packages = [ pkgs.nautilus ];
    services.gvfs.enable = true;
  };
}
