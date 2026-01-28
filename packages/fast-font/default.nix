{stdenv}:
stdenv.mkDerivation rec {
  pname = "fast-font";
  version = "1";

  src = ./.;

  installPhase = ''
    mkdir -p $out/share/fonts/truetype/fast-font
    cp *.ttf $out/share/fonts/truetype/fast-font/
  '';
}
