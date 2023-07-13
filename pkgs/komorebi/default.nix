{ lib, pkgs, stdenv, fetchFromGitHub }:

stdenv.mkDerivation rec {
  pname = "komorebi";
  version = "2.1";

  src = fetchFromGitHub {
    owner = "cheesecakeufo";
    repo = "komorebi";
    rev = "994725d147674bf7fe9392ccc1460cc41df1f8fb";
    sha256 = "1fdawd13v9z19ycbkv62h34msd0mdqm0bdml05ydjfm6dsi0zw6d";
  };

  buildInputs = with pkgs; [
    clutter
    clutter-gtk
    clutter-gst
    vala
    webkitgtk
    cmake
    pkg-config
    libgee
  ];

 # preConfigure = ''
 ##   substituteInPlace /cmake_install.cmake \
 #     --replace "\''${RUNTIME DESTINATION}" "$out/System/Applications" \
 # '';

  buildPhase = ''
    cmake && ls && make install
  '';

  installPhase = ''
    mkdir -p $out/bin
    mv komorebi $out/bin
  '';

  meta = with lib; {
    description = "A beautiful and customizable wallpaper manager for Linux.";
    homepage = "https://github.com/cheesecakeufo/komorebi";
    license = with licenses; [ gpl3Plus ];
    maintainers = [ maintainers.***REMOVED*** ];
    platforms = platforms.linux;
  };
}