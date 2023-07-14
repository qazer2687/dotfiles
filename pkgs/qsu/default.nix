{ lib
, stdenv
, fetchFromGitHub
}:

stdenv.mkDerivation rec {
  pname = "qsu";
  version = "0.1.9";

  src = fetchFromGitHub {
    owner = "***REMOVED***";
    repo = "qsu";
    rev = version;
    hash = "sha256-m+73RGemTUXnWvlKHBupSSLU+lwmToB2Hd8JjTLgW0w=";
  };

  installPhase = ''
    mkdir -p $out/bin
    cp -R build/bin/qls $out/bin/qls
    cp -R build/bin/qpwd $out/bin/qpwd
    cp -R build/bin/qcp $out/bin/qcp
    rm -rf build/*
  '';

  meta = with lib; {
    description = "";
    homepage = "https://github.com/***REMOVED***/qsu";
    license = licenses.mit;
    maintainers = with maintainers; [ ];
  };
}
