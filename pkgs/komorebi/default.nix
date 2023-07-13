{ lib, pkgs, stdenv, fetchFromGitHub }:

stdenv.mkDerivation rec {
  pname = "komorebi";
  version = "2.2.1";

  src = fetchFromGitHub {
    owner = "Komorebi-Fork";
    repo = "komorebi";
    rev = "e752d26e21ebc0129bffb61e0da9516c3f29b1e7";
    sha256 = "06gks28zhjbdff2ryhi1wf6g6kqw66chw06hb1p85fxiskspli5w";
  };

  buildInputs = with pkgs; [
    clutter
    clutter-gtk
    clutter-gst
    vala
    webkitgtk
    meson
    pkg-config
    libgee
    ninja
    gtk3
    glib
    gst_all_1.gstreamer # not sure if i need all these but i will figure out after i fix the other thing
    gst_all_1.gst-plugins-good
    gst_all_1.gst-plugins-base
    makeWrapper
  ];

  buildPhase = ''
    meson build .. --prefix=$out
    cd build
    meson compile
  '';

  installPhase = ''
    meson install 
    mkdir -p $out/share/glib-2.0/schemas
    glib-compile-schemas $out/share/glib-2.0/schemas
  '';

#  postFixup = ''
# '';

  meta = with lib; {
    description = "A beautiful and customizable wallpaper manager for Linux.";
    homepage = "https://github.com/Komorebi-Fork/komorebi";
    license = with licenses; [ gpl3Plus ];
    maintainers = [ maintainers.***REMOVED*** ];
    platforms = platforms.linux;
  };
}