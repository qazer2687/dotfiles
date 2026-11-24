{
  lib,
  stdenv,
  pkg-config,
  hyprland,
}:
stdenv.mkDerivation {
  pname = "peek";
  version = "0.1.0";
  src = ./.;

  nativeBuildInputs = [pkg-config] ++ hyprland.nativeBuildInputs;
  buildInputs = [hyprland] ++ hyprland.buildInputs;

  dontUseCmakeConfigure = true;

  installPhase = ''
    runHook preInstall
    install -Dm755 peek.so $out/lib/peek.so
    runHook postInstall
  '';

  meta = {
    description = "Hold-to-show workspace thumbnail overlay for Hyprland";
    license = lib.licenses.gpl2Only;
    platforms = lib.platforms.linux;
  };
}
