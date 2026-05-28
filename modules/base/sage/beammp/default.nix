{
  lib,
  config,
  pkgs,
  inputs,
  ...
}: {
  options.modules.beammp.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.beammp.enable {
    environment.systemPackages = 
    let
      beammpIcon = pkgs.fetchurl {
        url = "https://beammp.com/assets/BeamMP_blk-BycyukAv.png";
        sha256 = "sha256-7osWdvH3vG6Jf2I9U0/OPPVSL8wDlTIenwytng5xOyM=";
      };


      launcher = pkgs.buildFHSEnv {
        name = "BeamMP-Launcher";
        targetPkgs = pkgs: with pkgs; [
          nspr
          libuuid
          fontconfig
          freetype
          glib
          nss
          dbus
          at-spi2-atk
          cups
          libx11
          libxcomposite
          libxdamage
          libxext
          libxfixes
          libxrandr
          libxcb
          libxkbcommon
          cairo
          pango
          udev
          alsa-lib
          libgbm


          libGL
          libGLU
          vulkan-loader
          vulkan-tools
          libvdpau
          libva
        ];
        runScript = "${pkgs.beammp-launcher}/bin/BeamMP-Launcher";
      };


      desktopItem = pkgs.makeDesktopItem {
        name = "BeamMP-Launcher";
        desktopName = "BeamMP";
        comment = "BeamNG.drive Multiplayer";
        exec = "${launcher}/bin/BeamMP-Launcher";
        icon = "${beammpIcon}";
        categories = [ "Game" ];
        terminal = true;
      };
    in
    [ launcher desktopItem ];
  };
}
