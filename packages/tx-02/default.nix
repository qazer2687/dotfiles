{stdenv}:
stdenv.mkDerivation rec {
  pname = "tx-02";
  version = "1";
  # TX-02 Retina
  src = ./TX02.otf;

  dontUnpack = true;

  installPhase = ''
    mkdir -p $out/share/fonts/opentype/tx02
    cp $src $out/share/fonts/opentype/tx02
  '';
}
