{ stdenv }:

stdenv.mkDerivation rec {
  pname = "pragmatapro";
  version = "0.820";
  src = ./PragmataPro.ttf;

  installPhase = ''
    mkdir -p $out/share/fonts/truetype/pragmatapro
    cp $src $out/share/fonts/truetype/pragmatapro/
  '';
}
