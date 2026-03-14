{
  stdenv,
  lib,
  appimageTools,
  fetchurl,
  makeDesktopItem,
  copyDesktopItems,
}: let
  pname = "helium";
  version = "0.10.4.1";

  architectures = {
    "x86_64-linux" = {
      arch = "x86_64";
      hash = "sha256-FCLCt0T+U8JqUkFVAfl//OtnWsNoN8lWHIiMJws2Mqo=";
    };
    "aarch64-linux" = {
      arch = "arm64";
      hash = "sha256-pLyTS69sPs8j7zALwc3yQ74/3ZHw1G9aebxGcjtBU/I=";
    };
  };

  src = let
    inherit (architectures.${stdenv.hostPlatform.system}) arch hash;
  in
    fetchurl {
      url = "https://github.com/imputnet/helium-linux/releases/download/${version}/helium-${version}-${arch}.AppImage";
      inherit hash;
    };
in
  appimageTools.wrapType2 {
    inherit pname version src;
    nativeBuildInputs = [copyDesktopItems];
    desktopItems = [
      (makeDesktopItem {
        })
    ];
    meta = {
      platforms = lib.attrNames architectures;
    };
  }
