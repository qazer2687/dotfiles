# beetcamp.nix
{ lib, python3, fetchFromGitHub }:

python3.pkgs.buildPythonPackage rec {
  pname = "beetcamp";
  version = "0.23.0";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "snejus";
    repo = "beetcamp";
    rev = version;
    hash = "";
  };

  build-system = [ python3.pkgs.poetry-core ];
  dependencies = with python3.pkgs; [
    httpx
    ordered-set
    packaging
    pycountry
  ];

  pythonImportsCheck = [ "beetsplug.bandcamp" ];

  meta = {
    description = "Bandcamp autotagger source for beets";
    homepage = "https://github.com/snejus/beetcamp";
    license = lib.licenses.gpl2Only;
  };
}