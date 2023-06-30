{ inputs, lib, config, pkgs, ... }:
{
  options.modules.misc.tlp.enable = lib.mkEnableOption "";
  config = lib.mkIf config.modules.misc.tlp.enable {
    services.tlp.enable = true;
  };
}