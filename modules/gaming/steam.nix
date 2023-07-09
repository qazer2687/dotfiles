{ inputs, lib, config, pkgs, ... }: {

  options.modules.gaming.steam.enable = lib.mkEnableOption "";
  
  config = lib.mkIf config.modules.gaming.steam.enable {
    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true; 
      dedicatedServer.openFirewall = true; 
    };
  };
}