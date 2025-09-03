{stdenv}:
stdenv.mkDerivation rec {
  pname = "TX02";
  version = "1";
  # TX-02 Retina
  src = ./TX-02-Regular.otf;

  dontUnpack = true;

  installPhase = ''
    mkdir -p $out/share/fonts/opentype/TX02
    cp $src $out/share/fonts/opentype/TX02
  '';
}
