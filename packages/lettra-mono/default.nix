{ stdenv }:
stdenv.mkDerivation rec {
  pname = "lettra-mono";
  version = "1";
  
  src = ./.;
  
  installPhase = ''
    mkdir -p $out/share/fonts/truetype/lettra-mono
    cp *.ttf $out/share/fonts/truetype/lettra-mono/
  '';
}