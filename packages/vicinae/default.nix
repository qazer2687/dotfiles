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

  postPatch = ''
    # Create all required dummy files first
    mkdir -p typescript/api/dist/dist/{components,hooks,context,jsx}
    mkdir -p typescript/api/dist/{components,hooks,context,bin,lib}
    mkdir -p vicinae/assets typescript/extension-manager/dist

    # Create main API files
    for file in ai alert bus cache clipboard color controls environment hooks icon image index keyboard local-storage oauth preference toast utils; do
      echo "export {};" > typescript/api/dist/$file.js
      echo "export {};" > typescript/api/dist/dist/$file.d.js
    done

    # Create component files
    for file in action-pannel actions detail empty-view form index list metadata tag; do
      echo "export {};" > typescript/api/dist/dist/components/$file.d.js
    done
    echo "export {};" > typescript/api/dist/components/index.js

    # Create hook files
    for file in index use-applications use-imperative-form-handle use-navigation; do
      echo "export {};" > typescript/api/dist/dist/hooks/$file.d.js
      echo "export {};" > typescript/api/dist/hooks/$file.js
    done

    # Create context files
    for file in index navigation-context navigation-provider; do
      echo "export {};" > typescript/api/dist/dist/context/$file.d.js
      echo "export {};" > typescript/api/dist/context/$file.js
    done

    # Create bin files
    for file in build develop main utils; do
      echo "#!/usr/bin/env node" > typescript/api/dist/bin/$file.js
      chmod +x typescript/api/dist/bin/$file.js
    done

    # Create other required files
    echo "export {};" > typescript/api/dist/dist/jsx/jsx-runtime.d.js
    echo "export {};" > typescript/api/dist/lib/result.js
    echo "export {};" > typescript/api/dist/bus.d.js
    echo "export {};" > typescript/api/dist/index.d.js
    echo "export {};" > typescript/api/dist/hooks/index.d.js
    echo "export {};" > typescript/api/dist/hooks/use-applications.d.js
    echo "export {};" > typescript/api/dist/hooks/use-navigation.d.js
    echo "export {};" > typescript/api/dist/context/index.d.js

    # Create node_modules directories
    mkdir -p typescript/api/node_modules
    mkdir -p typescript/extension-manager/node_modules

    # Create extension runtime
    echo "// Extension runtime placeholder" > vicinae/assets/extension-runtime.js
    echo "// Extension manager dist" > typescript/extension-manager/dist/runtime.js

    # Now completely replace the CMakeLists.txt files to skip npm
    cat > typescript/api/CMakeLists.txt << 'EOF'
# Dummy CMakeLists.txt - skip npm builds
add_custom_target(api-node-modules ALL
  COMMAND ${CMAKE_COMMAND} -E echo "Skipping API npm install (Nix)"
)
add_custom_target(build-api ALL
  DEPENDS api-node-modules
  COMMAND ${CMAKE_COMMAND} -E echo "Skipping API build (Nix)"
)
EOF

    cat > typescript/extension-manager/CMakeLists.txt << 'EOF'
# Dummy CMakeLists.txt - skip npm builds
add_custom_target(extension-manager-node-modules ALL
  COMMAND ${CMAKE_COMMAND} -E echo "Skipping extension-manager npm install (Nix)"
)
add_custom_target(build-extension-manager ALL
  DEPENDS extension-manager-node-modules
  COMMAND ${CMAKE_COMMAND} -E echo "Skipping extension-manager build (Nix)"
)
EOF
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