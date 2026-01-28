{stdenv}:
stdenv.mkDerivation rec {
  pname = "space-grotesk";
  version = "1";

  src = ./.;

  installPhase = ''
    mkdir -p $out/share/fonts/truetype/space-grotesk
    cp *.ttf $out/share/fonts/truetype/space-grotesk/
  '';
}
