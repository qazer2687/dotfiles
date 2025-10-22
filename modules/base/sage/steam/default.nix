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
      extest.enable = true;
      package = pkgs.steam.override {
        extraPkgs = pkgs':
          with pkgs'; [
            # X11 Libraries
            xorg.libXcursor
            xorg.libXi
            xorg.libXinerama
            xorg.libXScrnSaver

            # System Libraries
            stdenv.cc.cc.lib
            gperftools
            keyutils
            libkrb5
            libpng
            libpulseaudio
            libvorbis
            mangohud
            gamemode
            gamescope

            # Proton
            proton-ge-bin
            protonup-qt
          ];
      };
    };
  };
}
