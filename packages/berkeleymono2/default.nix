{stdenv}:
stdenv.mkDerivation rec {
  pname = "berkeleymono2";
  version = "1";
  src = ./TX-02-Retina.otf;

  dontUnpack = true;

  installPhase = ''
    mkdir -p $out/share/fonts/opentype/berkeleymono2
    cp $src $out/share/fonts/opentype/berkeleymono2
  '';
}
