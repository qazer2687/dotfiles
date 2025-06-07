{
  lib,
  fetchFromGitea,
  installShellFiles,
  libX11,
  libinput,
  libxcb,
  libxkbcommon,
  pixman,
  pkg-config,
  stdenv,
  testers,
  nixosTests,
  wayland,
  wayland-protocols,
  wayland-scanner,
  wlroots,
  writeText,
  xcbutilwm,
  # Boolean flags
  withCustomConfigH ? (configH != null),
  # Configurable options
  configH ? null,
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
      libinput
      libxcb
      libxkbcommon
      pixman
      wayland
      wayland-protocols
      wlroots
    ];

  outputs = [
    "out"
    "man"
  ];

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
    ];

  strictDeps = true;

  # required for whitespaces in makeFlags
  __structuredAttrs = true;

  passthru = {
    tests = {
      version = testers.testVersion {
        package = finalAttrs.finalPackage;
        # `dwl -v` emits its version string to stderr and returns 1
        command = "dwl -v 2>&1; return 0";
      };
      basic = nixosTests.dwl;
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