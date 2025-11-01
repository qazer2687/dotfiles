{
  stdenv,
  fetchFromGitHub,
  cmake,
  pkg-config,
  kdePackages,
  rapidfuzz-cpp,
  protobuf,
  grpc-tools,
  nodejs,
  minizip-ng,
  cmark-gfm,
  libqalculate,
  ninja,
  lib,
  fetchNpmDeps,
  protoc-gen-js,
  rsync,
  which,
  autoPatchelfHook,
  writeShellScriptBin,
  minizip,
  qt6,
  breakpointHook,
  typescript,
  wayland,
}:
let
  src = fetchFromGitHub {
    owner = "vicinaehq";
    repo = "vicinae";
    rev = "v0.8.1";
    hash = "sha256-HlNorGRnYr+dmEQkn0AAOyhoma+0X3m6S9Jev7MwvSU=";
  };

  # Prepare node_modules for api folder
  apiDeps = fetchNpmDeps {
    src = src + /api;
    hash = "sha256-7rsaGjs1wMe0zx+/BD1Mx7DQj3IAEZQvdS768jVLl3E=";
  };
  ts-protoc-gen-wrapper = writeShellScriptBin "protoc-gen-ts_proto" ''
    exec node /build/source/vicinae-upstream/api/node_modules/.bin/protoc-gen-ts_proto
  '';

  # Prepare node_modules for extension-manager folder
  extensionManagerDeps = fetchNpmDeps {
    src = src + /extension-manager;
    hash = "sha256-7kScWi1ySUBTDsGQqgpt2wYmujP9Mlwq3x2FKOlGwgo=";
  };

in
  stdenv.mkDerivation rec {
    pname = "vicinae";
    version = src.rev;

    inherit src;

    cmakeFlags = [
        "-DVICINAE_GIT_TAG=${src.rev}"
        "-DCMAKE_INSTALL_PREFIX=${placeholder "out"}"
        "-DCMAKE_INSTALL_DATAROOTDIR=share"
        "-DCMAKE_INSTALL_BINDIR=bin"
        "-DCMAKE_INSTALL_LIBDIR=lib"
    ];

    nativeBuildInputs = [
      ts-protoc-gen-wrapper
      extensionManagerDeps
      autoPatchelfHook
      cmake
      ninja
      nodejs
      pkg-config
      qt6.wrapQtAppsHook
      rapidfuzz-cpp
      protoc-gen-js
      protobuf
      grpc-tools
      which
      rsync
      breakpointHook
      typescript
    ];

    buildInputs = [
      qt6.qtbase
      qt6.qtsvg
      qt6.qttools
      qt6.qtwayland
      qt6.qtdeclarative
      qt6.qt5compat
      wayland
      kdePackages.qtkeychain
      kdePackages.layer-shell-qt
      minizip
      grpc-tools
      protobuf
      nodejs
      minizip-ng
      cmark-gfm
      libqalculate
    ];

    configurePhase = ''
      cmake -G Ninja -B build $cmakeFlags
    '';

    buildPhase = ''
      export npm_config_cache=${apiDeps}
      cd /build/source/api
      npm i --ignore-scripts
      patchShebangs /build/source/api
      npm rebuild --foreground-scripts
      export npm_config_cache=${extensionManagerDeps}
      cd /build/source/extension-manager
      npm i --ignore-scripts
      patchShebangs /build/source/extension-manager
      npm rebuild --foreground-scripts
      cd /build/source
      substituteInPlace cmake/ExtensionApi.cmake cmake/ExtensionManager.cmake --replace "COMMAND npm install" ""
      cmake --build build
      cd /build/source
    '';

    dontWrapQtApps = true;
    preFixup = ''
        wrapQtApp "$out/bin/vicinae" --prefix LD_LIBRARY_PATH : ${lib.makeLibraryPath buildInputs}
    '';
    postFixup = ''
        wrapProgram $out/bin/vicinae \
        --prefix PATH : ${lib.makeBinPath [
          nodejs
          qt6.qtwayland
          wayland
          (placeholder "out")
        ]}
    '';

    installPhase = ''
      cmake --install build
    '';
}