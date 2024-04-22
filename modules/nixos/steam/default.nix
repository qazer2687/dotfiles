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
          xorg.libXcursor
          xorg.libXi
          xorg.libXinerama
          xorg.libXScrnSaver
          libpng
          libpulseaudio
          libvorbis
          stdenv.cc.cc.lib
          libkrb5
          keyutils
          gamemode
          gamescope
          mangohud
          openssl
        ];
      };
    };
    programs.gamescope = {
      enable = true;
      capSysNice = false; # disabled because of "failed to inherit capabilities: Operation not permitted" error
      args = [
        "-w 1720" # width
        "-h 1080" # height
        "-S stretch" # scaling
        "-f" # fullscreen
        "-e" # steam integration
      ];
    }; 
    # capSysNice workaround
    security.wrappers.gamescope = {
      owner = "root";
      group = "root";
      source = "${pkgs.gamescope}/bin/gamescope";
      capabilities = "cap_sys_nice+pie";
    };

  };
}
