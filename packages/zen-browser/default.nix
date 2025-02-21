{ stdenv, fetchurl, lib, appimage-run }:

stdenv.mkDerivation rec {
  pname = "zen-browser";
  version = "latest";

  src = fetchurl {
    url = "https://github.com/zen-browser/desktop/releases/latest/download/zen-aarch64.AppImage";
    sha256 = "16k37ngl4qpqwwj6f9q8jpn20pk8887q8zc0l7qivshmhfib36qq";
  };

  buildInputs = [ appimage-run ];

  installPhase = ''
    # Copy the AppImage into the package output.
    mkdir -p $out/bin
    cp ${src} $out/bin/zen-browser.AppImage
    chmod +x $out/bin/zen-browser.AppImage

    # Install a desktop entry for integration with XDG menus.
    mkdir -p $out/share/applications
    cat > $out/share/applications/zen-browser.desktop <<EOF
    [Desktop Entry]
    Name=Zen Browser
    GenericName=Zen
    Exec=appimage-run $out/bin/zen-browser.AppImage
    Terminal=false
    Type=Application
    Categories=Network;WebBrowser;
    EOF
  '';

  meta = with lib; {
    description = "Zen Browser launcher using appimage.";
    homepage = "https://github.com/zen-browser/desktop";
    license = "unfree";
    platforms = [ "aarch64-linux" ];
  };
}
