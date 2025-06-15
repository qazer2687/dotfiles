{
  lib,
  stdenv,
  installShellFiles,
  libX11,
  libinput,
  libxcb,
  libxkbcommon,
  pixman,
  pkg-config,
  wayland-scanner,
  wayland,
  wayland-protocols,
  wlroots_0_18,
  xcbutilwm,
  xwayland,
  gnumake,
  tllist,
  fcft,
  libdrm,
  enableXWayland ? true,
}:

stdenv.mkDerivation {
  pname = "dwl";
  version = "0.7";
  src = ./src;

  nativeBuildInputs = [ 
    installShellFiles
    pkg-config
    gnumake
  ];
  
  buildInputs = [
    libinput
    libxcb
    libxkbcommon
    pixman
    wayland
    wayland-protocols
    wlroots_0_18
    wayland-scanner
    tllist
    fcft
    libdrm
  ] ++ lib.optionals enableXWayland [
    libX11
    xcbutilwm
    xwayland
  ];
  
  outputs = [ "out" "man" ];

  makeFlags = [
    "PKG_CONFIG=${stdenv.cc.targetPrefix}pkg-config"
    "WAYLAND_SCANNER=wayland-scanner"
    "PREFIX=$(out)"
    "MANDIR=$(man)/share/man"
  ];
  
  buildPhase = ''
    make clean
    make
  '';

  meta = {
    homepage = "https://github.com/qazer2687/dotfiles";
    license = lib.licenses.gpl3Only;
    maintainers = [ lib.maintainers.AndersonTorres ];
    inherit (wayland.meta) platforms;
    mainProgram = "dwl";
  };
}