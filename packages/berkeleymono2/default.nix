{stdenv}:
stdenv.mkDerivation rec {
  pname = "tx-02";
  version = "1";
  # TX-02 Retina
  src = ./TX-02.otf;

  dontUnpack = true;

  installPhase = ''
    mkdir -p $out/share/fonts/opentype/tx-02
    cp $src $out/share/fonts/opentype/tx-02
  '';
}
