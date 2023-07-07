{ inputs, lib, config, pkgs, ... }:
{
  options.modules.gaming.steam.enable = lib.mkEnableOption "";
  config = lib.mkIf config.modules.gaming.steam.enable {
    programs.steam = {
      enable = true;
      remotePlay.openFirewall = false; 
      dedicatedServer.openFirewall = false; 
    };
    nixpkgs.config.packageOverrides = pkgs: {
      steam = pkgs.steam.override {
        extraPkgs = pkgs: with pkgs; [
          pango
          libthai
          harfbuzz
        ];
      };
    };
  };
}