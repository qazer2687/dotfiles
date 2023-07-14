{ lib
, stdenv
, fetchFromGitHub
}:

stdenv.mkDerivation rec {
  pname = "qsh";
  version = "0.1.0-alpha";

  src = fetchFromGitHub {
    owner = "***REMOVED***";
    repo = "qsh";
    rev = "v${version}";
    hash = "sha256-8DOWmnya6WrJ49EGzS56V+ujL4HgsCN4dhYrPZ4KAXs=";
  };

  meta = with lib; {
    description = "";
    homepage = "https://github.com/***REMOVED***/qsh";
    license = licenses.mit;
    maintainers = with maintainers; [ ***REMOVED*** ];
  };
}
