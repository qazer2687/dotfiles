{
  lib,
  installShellFiles,
  libX11,
  libinput,
  libxcb,
  libdrm,
  libxkbcommon,
  pixman,
  fcft,
  pkg-config,
  stdenv,
  testers,
  wayland,
  wayland-protocols,
  wayland-scanner,
  wlroots_0_18,
  writeText,
  xcbutilwm,
  xwayland,
  # Boolean flags
  enableXWayland ? true,
  withCustomConfigH ? (configH != null),
  # Configurable options
  configH ?
    if conf != null then
      lib.warn ''
        conf parameter is deprecated;
        use configH instead
      '' conf
    else
      null,
  # Deprecated options
  # Remove them before next version of either Nixpkgs or dwl itself
  conf ? null,
}:

# If we set withCustomConfigH, let's not forget configH
assert withCustomConfigH -> (configH != null);
stdenv.mkDerivation (finalAttrs: {
  pname = "dwl";
  version = "0.7";
  src = ./src;

  nativeBuildInputs = [
    installShellFiles
    pkg-config
    wayland-scanner
  ];

  buildInputs =
    [
      libdrm
      libdrm.dev
      fcft
      fcft.dev
      libinput
      libxcb
      libxkbcommon
      pixman
      wayland
      wayland-protocols
      wlroots_0_18
    ]
    ++ lib.optionals enableXWayland [
      libX11
      xcbutilwm
      xwayland
    ];

  outputs = [
    "out"
    "man"
  ];
  
  # Set environment variables that will be available during all build phases
    NIX_CFLAGS_COMPILE = "-I${libdrm.dev}/include";
    
    # Configure environment for pkg-config
    configurePhase = ''
      runHook preConfigure
      
      # Set up pkg-config paths
      export PKG_CONFIG_PATH="${fcft}/lib/pkgconfig:${libdrm.dev}/lib/pkgconfig:$PKG_CONFIG_PATH"
      export CPATH="${libdrm.dev}/include:$CPATH"
      
      # Debug output
      echo "=== ARCHITECTURE & PKG-CONFIG DEBUG ==="
      echo "Architecture: ${stdenv.hostPlatform.system}"
      echo "PKG_CONFIG_PATH: $PKG_CONFIG_PATH"
      echo "CPATH: $CPATH"
      echo ""
      echo "Checking fcft package location:"
      find ${fcft} -name "*.pc" 2>/dev/null || echo "No .pc files found in fcft"
      echo "Checking libdrm package location:"
      find ${libdrm.dev} -name "*.pc" 2>/dev/null || echo "No .pc files found in libdrm.dev"
      echo ""
      echo "Available packages containing 'fcft' or 'drm':"
      pkg-config --list-all | grep -E "(fcft|drm)" || echo "No matching packages found"
      echo "Testing fcft:"
      pkg-config --exists fcft && echo "fcft found" || echo "fcft NOT found"
      echo "Testing libdrm:"
      pkg-config --exists libdrm && echo "libdrm found" || echo "libdrm NOT found"
      echo "============================================"
      
      runHook postConfigure
    '';

  postPatch =
    let
      configFile =
        if lib.isDerivation configH || builtins.isPath configH then
          configH
        else
          writeText "config.h" configH;
    in
    lib.optionalString withCustomConfigH "cp ${configFile} config.h";

  makeFlags =
    [
      "PKG_CONFIG=${stdenv.cc.targetPrefix}pkg-config"
      "WAYLAND_SCANNER=wayland-scanner"
      "PREFIX=$(out)"
      "MANDIR=$(man)/share/man"
    ]
    ++ lib.optionals enableXWayland [
      ''XWAYLAND="-DXWAYLAND"''
      ''XLIBS="xcb xcb-icccm"''
    ];

  strictDeps = true;

  # required for whitespaces in makeFlags
  __structuredAttrs = true;

  passthru = {
    tests.version = testers.testVersion {
      package = finalAttrs.finalPackage;
      # `dwl -v` emits its version string to stderr and returns 1
      command = "dwl -v 2>&1; return 0";
    };
  };

  meta = {
    homepage = "https://codeberg.org/dwl/dwl";
    changelog = "https://codeberg.org/dwl/dwl/src/branch/${finalAttrs.version}/CHANGELOG.md";
    description = "Dynamic window manager for Wayland";
    longDescription = ''
      dwl is a compact, hackable compositor for Wayland based on wlroots. It is
      intended to fill the same space in the Wayland world that dwm does in X11,
      primarily in terms of philosophy, and secondarily in terms of
      functionality. Like dwm, dwl is:

      - Easy to understand, hack on, and extend with patches
      - One C source file (or a very small number) configurable via config.h
      - Tied to as few external dependencies as possible
    '';
    license = lib.licenses.gpl3Only;
    maintainers = [ ];
    inherit (wayland.meta) platforms;
    mainProgram = "dwl";
  };
})