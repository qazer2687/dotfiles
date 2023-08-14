{
  lib,
  config,
  ...
}: {
  options.systemModules.steam.enable = lib.mkEnableOption "";

  config = lib.mkIf config.systemModules.steam.enable {
    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
    };
  };
}