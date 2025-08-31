{
  stdenv,
  fetchFromGitHub,
  fetchurl,
  python3,
  squashfsTools,
  nspr,
}: let
  widevine-installer = fetchFromGitHub {
    owner = "AsahiLinux";
    repo = "widevine-installer";
    rev = "7a3928fe1342fb07d96f61c2b094e3287588958b";
    sha256 = "sha256-XI1y4pVNpXS+jqFs0KyVMrxcULOJ5rADsgvwfLF6e0Y=";
  };
  lacros-image = fetchurl {
    url = let
      distfiles_base = "https://commondatastorage.googleapis.com/chromeos-localmirror/distfiles";
      lacros_name = "chromeos-lacros-arm64-squash-zstd";
      lacrosVersion = "120.0.6098.0";
    in "${distfiles_base}/${lacros_name}-${lacrosVersion}";
    hash = "sha256-OKV8w5da9oZ1oSGbADVPCIkP9Y0MVLaQ3PXS3ZBLFXY=";
  };
in
  stdenv.mkDerivation {
    name = "widevine";
    version = "4.10.2662.3";

    dontUnpack = true;
    dontBuild = true;

    buildInputs = [python3 squashfsTools];

    installPhase = ''
      mkdir $out
      unsquashfs -q ${lacros-image} 'WidevineCdm/*'
      python3 ${widevine-installer}/widevine_fixup.py squashfs-root/WidevineCdm/_platform_specific/cros_arm64/libwidevinecdm.so $out/libwidevinecdm.so
      mv squashfs-root/WidevineCdm/manifest.json $out/
      mv squashfs-root/WidevineCdm/LICENSE $out/
      patchelf --add-rpath ${nspr}/lib $out/libwidevinecdm.so
    '';
  }
