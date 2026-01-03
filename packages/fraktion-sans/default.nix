{ stdenv }:
stdenv.mkDerivation rec {
  pname = "fraktion-sans";
  version = "1";
  
  src = ./.;
  
  installPhase = ''
    mkdir -p $out/share/fonts/truetype/fraktion-sans
    cp *.otf $out/share/fonts/truetype/fraktion-sans/
  '';
}