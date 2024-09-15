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
      ## Used to translate X11 inputs to uinputs for wayland compat.
      extest.enable = true;
      gamescopeSession.enable = true;
      package = pkgs.steam.override {
        extraPkgs = _pkgs:
          with pkgs; [
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
      capSysNice = true;
      args = [
        "-w 2560" # width
        "-h 1080" # height
        "-S stretch" # scaling
        "-f" # fullscreen
        "-e" # steam integration
      ];
    };
  };
}
