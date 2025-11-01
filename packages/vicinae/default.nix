{
  lib,
  stdenv,
  fetchFromGitHub,
  cmake,
  ninja,
  nodejs,
  qt6,
  qt6Packages,
  kdePackages,
  protobuf,
  cmark-gfm,
  libqalculate,
  minizip,
  rapidfuzz-cpp,
}:
stdenv.mkDerivation rec {
  pname = "vicinae";
  version = "0.16.0";

  src = fetchFromGitHub {
    owner = "vicinaehq";
    repo = "vicinae";
    rev = "v${version}";
    hash = "sha256-kZAef+/eQWHKiFvYw8fNxAFRgpX8Ms/+G0JFg5qP1sQ=";
  };

  nativeBuildInputs = [
    cmake
    ninja
    nodejs
    qt6.wrapQtAppsHook
  ];

  buildInputs = [
    qt6.qtbase
    qt6.qtsvg
    qt6.qtwayland
    kdePackages.layer-shell-qt
    protobuf
    cmark-gfm
    libqalculate
    minizip
    qt6Packages.qtkeychain
    rapidfuzz-cpp
  ];

  preConfigure = ''
    export HOME=$TMPDIR
  '';

  patchPhase = ''
    runHook prePatch

    # Replace the entire ExtensionApi.cmake to skip npm builds
    cat > cmake/ExtensionApi.cmake << 'EOF'
    set(EXT_API_SRC_DIR "''${CMAKE_SOURCE_DIR}/api")
    set(EXT_API_OUT_DIR "''${CMAKE_SOURCE_DIR}/api/dist")
    set(API_DIST_DIR "''${CMAKE_SOURCE_DIR}/api/dist")
    add_custom_target(build-api ALL COMMENT "Skipping API build (Nix)")
    EOF

    if [ -f cmake/ExtensionManager.cmake ]; then
      cat > cmake/ExtensionManager.cmake << 'EOF'
    set(EXT_MANAGER_DIST "''${CMAKE_SOURCE_DIR}/vicinae/assets/extension-runtime.js")
    add_custom_target(build-extension-manager ALL COMMENT "Skipping Extension Manager build (Nix)")
    EOF
    fi

    # Create all required dummy files that the build expects
    mkdir -p api/dist/dist/components api/dist/dist/hooks api/dist/dist/context api/dist/dist/jsx
    mkdir -p api/dist/components api/dist/hooks api/dist/context api/dist/bin api/dist/lib
    mkdir -p vicinae/assets extension-manager/dist

    # Create main API files
    for file in ai alert bus cache clipboard color controls environment hooks icon image index keyboard local-storage oauth preference toast utils; do
      echo "export {};" > api/dist/$file.js
      echo "export {};" > api/dist/dist/$file.d.js
    done

    # Create component files
    for file in action-pannel actions detail empty-view form index list metadata tag; do
      echo "export {};" > api/dist/dist/components/$file.d.js
    done
    echo "export {};" > api/dist/components/index.js

    # Create hook files
    for file in index use-applications use-imperative-form-handle use-navigation; do
      echo "export {};" > api/dist/dist/hooks/$file.d.js
      echo "export {};" > api/dist/hooks/$file.js
    done

    # Create context files
    for file in index navigation-context navigation-provider; do
      echo "export {};" > api/dist/dist/context/$file.d.js
      echo "export {};" > api/dist/context/$file.js
    done

    # Create bin files
    for file in build develop main utils; do
      echo "#!/usr/bin/env node" > api/dist/bin/$file.js
    done

    # Create other required files
    echo "export {};" > api/dist/dist/jsx/jsx-runtime.d.js
    echo "export {};" > api/dist/lib/result.js
    echo "export {};" > api/dist/bus.d.js
    echo "export {};" > api/dist/index.d.js
    echo "export {};" > api/dist/hooks/index.d.js
    echo "export {};" > api/dist/hooks/use-applications.d.js
    echo "export {};" > api/dist/hooks/use-navigation.d.js
    echo "export {};" > api/dist/context/index.d.js

    # Create extension runtime
    echo "// Extension runtime placeholder" > vicinae/assets/extension-runtime.js
    echo "// Extension manager dist" > extension-manager/dist/runtime.js

    runHook postPatch
  '';

  cmakeFlags = [
    "-G Ninja"
    "-DBUILD_TESTING=OFF"
  ];

  meta = with lib; {
    description = "A high-performance, native launcher for Linux — built with C++ and Qt";
    homepage = "https://vicinae.com";
    license = licenses.gpl3Only;
    maintainers = with maintainers; [];
    platforms = platforms.linux;
    mainProgram = "vicinae";
  };
}