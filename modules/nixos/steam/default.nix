{
  lib,
  config,
  self,
  ...
}: {
  options.modules.steam.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.steam.enable {
    programs.steam = {
      enable = true;
      gamescopeSession.enable = true;
      package = pkgs.steam.override {
        extraPkgs = pkgs:
          with self.packages; [
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
  };
}
