{
  stdenv,
  widevine-cdm,
}:

stdenv.mkDerivation {
  name = "widevine";
  version = widevine-cdm.version;

  buildCommand = ''
    mkdir -p $out/gmp-widevinecdm/system-installed
    ln -s "${widevine-cdm}/share/google/chrome/WidevineCdm/manifest.json" $out/gmp-widevinecdm/system-installed/manifest.json
    ln -s "${widevine-cdm}/share/google/chrome/WidevineCdm/_platform_specific/linux_arm64/libwidevinecdm.so" $out/gmp-widevinecdm/system-installed/libwidevinecdm.so
  '';

  meta = widevine-cdm.meta // {
    platforms = [ "aarch64-linux" ];
  };
}