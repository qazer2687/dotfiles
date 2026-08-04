{
  lib,
  stdenv,
  fetchFromGitHub,
  fetchPnpmDeps,
  nodejs,
  makeWrapper,
  jq,
  pnpmConfigHook,
  pnpm_11,
  versionCheckHook,
}: let
  version = "3.1.0";
  pnpm = pnpm_11;
in
stdenv.mkDerivation (finalAttrs: {
  pname = "immich-cli";
  inherit version;

  src = fetchFromGitHub {
    owner = "immich-app";
    repo = "immich";
    tag = "v${version}";
    hash = "sha256-C1JG9waQEmIEHWAoghGA0Sr6sa2tW5/1CcXeHRdIbKU=";
  };

  pnpmDeps = fetchPnpmDeps {
    pname = "immich";
    inherit (finalAttrs) version src;
    inherit pnpm;
    fetcherVersion = 4;
    hash = "sha256-sGzB2E3G1B5XOgQIv8bg51IGwJEE8JSIipfmnCUH/yw=";
  };

  nativeBuildInputs = [
    jq
    makeWrapper
    nodejs
    pnpmConfigHook
    pnpm
  ];

  buildPhase = ''
    runHook preBuild

    pnpm --filter @immich/cli... build

    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall

    local -r packageOut="$out/lib/node_modules/@immich/cli"

    pnpm --filter @immich/cli deploy --prod --no-optional "$packageOut"

    makeWrapper '${lib.getExe nodejs}' "$out/bin/immich" \
      --add-flags "$packageOut/dist/index.js"

    runHook postInstall
  '';

  doInstallCheck = true;

  nativeInstallCheckInputs = [
    versionCheckHook
  ];

  meta = {
    description = "Self-hosted photo and video backup solution (command line interface)";
    homepage = "https://immich.app/docs/features/command-line-interface";
    license = lib.licenses.agpl3Only;
    inherit (nodejs.meta) platforms;
    mainProgram = "immich";
  };
})
