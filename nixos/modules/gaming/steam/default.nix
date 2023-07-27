{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  options.systemModules.gaming.steam.enable = lib.mkEnableOption "";

  config = lib.mkIf config.systemModules.gaming.steam.enable {
    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
    };
  };
}
