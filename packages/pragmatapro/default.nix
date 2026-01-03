{ stdenv }:
stdenv.mkDerivation rec {
  pname = "pragmatapro";
  version = "1";
  
  src = ./.;
  
  installPhase = ''
    mkdir -p $out/share/fonts/truetype/pragmatapro
    cp *.ttf $out/share/fonts/truetype/pragmatapro/
  '';
}