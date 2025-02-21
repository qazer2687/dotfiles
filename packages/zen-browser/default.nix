{ lib, appimageTools, fetchurl }:

let
  version = "latest";
  pname = "zen-browser";
  src = fetchurl {
    url = "https://github.com/zen-browser/desktop/releases/latest/download/zen-aarch64.AppImage";
    sha256 = "K53Kb/EGzG3dxPb1UUvkP6xpK9rni0rNDqM3xE55KHo=";
  };

  desktopItem = makeDesktopItem {
    name = pname;
    exec = "${pname}";
    icon = pname;
    desktopName = "Zen Browser";
    comment = "A privacy-focused browser";
    categories = [ "Network" "WebBrowser" ];
  };

  appimageContents = appimageTools.extractType1 { inherit pname src; };
in
appimageTools.wrapType2 rec {
  inherit pname version src;

  extraInstallCommands = ''
    install -Dm644 ${desktopItem}/share/applications/*.desktop $out/share/applications/${pname}.desktop
  '';

  meta = with lib; {
    description = "A privacy-focused browser";
    homepage = "https://github.com/zen-browser/desktop";
    license = licenses.unfree;
    platforms = [ "aarch64-linux" ];
  };
}
