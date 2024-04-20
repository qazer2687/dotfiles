{
  lib,
  config,
  pkgs,
  ...
}: {
  options.modules.steam.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.steam.enable {
    programs.steam = {
      enable = true;
      gamescopeSession.enable = true;
      package = pkgs.steam.override {
        extraPkgs = pkgs: with pkgs; [
          libkrb5
          keyutils
        ];
      };
    };
    programs.gamescope = {
      enable = true;
    };
  };
}
