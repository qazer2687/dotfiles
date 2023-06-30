{ inputs, lib, config, pkgs, ... }:
{
  options.modules.gaming.steam.enable = lib.mkEnableOption "";
  config = lib.mkIf config.modules.gaming.steam.enable {
    programs.steam = {
      enable = true;
      remotePlay.openFirewall = false; 
      dedicatedServer.openFirewall = false; 
    };
    hardware.opengl.enable = true;
    hardware.opengl.driSupport32Bit = true;
  };
}