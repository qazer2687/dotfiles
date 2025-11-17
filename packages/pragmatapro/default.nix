{ stdenv }:
stdenv.mkDerivation rec {
  pname = "pragmatapro";
  version = "0.820";
  
  src = ./.;
  
  installPhase = ''
    mkdir -p $out/share/fonts/truetype/pragmatapro
    cp *.ttf $out/share/fonts/truetype/pragmatapro/
  '';
}