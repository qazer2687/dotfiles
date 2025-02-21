{ lib, appimageTools, fetchurl }:

let
  version = "latest";
  pname = "zen-browser";
  src = fetchurl {
    url = "https://github.com/zen-browser/desktop/releases/latest/download/zen-aarch64.AppImage";
    sha256 = "K53Kb/EGzG3dxPb1UUvkP6xpK9rni0rNDqM3xE55KHo=";
  };

  appimageContents = appimageTools.extractType1 { inherit pname src; };
in
appimageTools.wrapType2 rec {
  inherit pname version src;

  extraInstallCommands = ''
    substituteInPlace $out/share/applications/${pname}.desktop \
      --replace 'Exec=AppRun' 'Exec=${meta.mainProgram}'
  '';

  meta = with lib; {
    description = "Zen Browser launcher using AppImage.";
    homepage = "https://github.com/zen-browser/desktop";
    license = licenses.unfree;
    platforms = [ "aarch64-linux" ];
    mainProgram = "zen-browser";
  };
}
