{
  lib,
  config,
  ...
}: {
  options.modules.libinput.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.libinput.enable {
    nixpkgs.overlays = [
      (_final: prev: {
        libinput = prev.libinput.overrideAttrs (old: {
          version = "1.31.1";
          src = prev.fetchFromGitLab {
            domain = "gitlab.freedesktop.org";
            owner = "libinput";
            repo = "libinput";
            rev = "1.31.1";
            hash = "sha256-9Ko97vJyo4a9NUF7omqHTwzVV02sJ2EqpDIh+nPeLwk=";
          };
          patches =
            (old.patches or [])
            ++ [
              ./../../../../patches/libinput/disable-pinch.patch
            ];
        });
      })
    ];
  };
}
