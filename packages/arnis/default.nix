{
  lib,
  rustPlatform,
  fetchFromGitHub,
  pkg-config,
  autoPatchelfHook,
  openssl,
  zlib,
  glib,
  gtk3,
  webkitgtk_4_1,
}:
rustPlatform.buildRustPackage rec {
  pname = "arnis";
  version = "2.2.0";

  src = fetchFromGitHub {
    owner = "louis-e";
    repo = "arnis";
    tag = "v${version}";
    hash = "sha256-u5R1b+S99UOeGKudecQF92lIcbm+8aGD1ZlNtd3gmb0=";
  };

  cargoHash = "sha256-CgZU4DHu2r8uCKSDWtkClLMmXVmbMGWM2qNbk+isasA=";

  nativeBuildInputs = [pkg-config autoPatchelfHook];

  # Common system libraries Rust projects often depend on
  buildInputs = [openssl zlib glib gtk3 webkitgtk_4_1];

  # Enable autoPatchelf for automatic library linking
  dontPatchELF = false;

  meta = {
    description = "Real world location generator for Minecraft Java Edition";
    longDescription = ''
      Open source project written in Rust generates any chosen location from
      the real world in Minecraft Java Edition with a high level of detail.
    '';
    homepage = "https://github.com/louis-e/arnis";
    changelog = "https://github.com/louis-e/arnis/releases/tag/v${version}";
    license = lib.licenses.asl20;
    maintainers = with lib.maintainers; [nartsiss];
    mainProgram = "arnis";
  };
}
