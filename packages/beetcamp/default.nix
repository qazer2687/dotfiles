{
  lib,
  python3,
  fetchFromGitHub,
  pkgs,
}:

python3.pkgs.buildPythonApplication rec {
  pname = "beetcamp";
  version = "0.23.0";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "snejus";
    repo = "beetcamp";
    rev = version;
    hash = "sha256-8FEDpobEGZ0Lw1+JRoFIEe3AuiuX7dwsRab+P3hC3W0=";
  };

  build-system = [ python3.pkgs.poetry-core ];

  preBuild = ''
    HOME=$PWD
  '';

  nativeBuildInputs = [ pkgs.beets ];

  dependencies = with python3.pkgs; [
    httpx
    ordered-set
    packaging
    pycountry
  ];

  pythonImportsCheck = [ "beetsplug.bandcamp" ];

  meta = {
    description = "Bandcamp autotagger source for beets (https://beets.io)";
    homepage = "https://github.com/snejus/beetcamp";
    changelog = "https://github.com/snejus/beetcamp/blob/${src.rev}/CHANGELOG.md";
    license = lib.licenses.gpl2Only;
    maintainers = [ ];
    mainProgram = "beetcamp";
  };
}