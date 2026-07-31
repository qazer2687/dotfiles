{
  lib,
  config,
  ...
}: {
  options.modules.libinput.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.libinput.enable {
    nixpkgs.overlays = [
      (final: prev: {
        libinput = prev.libinput.overrideAttrs (old: {
          version = "1.31.1";
          src = prev.fetchFromGitLab {
            domain = "gitlab.freedesktop.org";
            owner = "libinput";
            repo = "libinput";
            rev = "1.31.1";
            hash = "sha256-4BCwICG4/p8+aWpKIFnAJD8MkPL51Lz0yI0vlhPFKws=";
          };
          patches = (old.patches or []) ++ [
            ./../../../../patches/libinput/disable-pinch.patch
          ];
        });
      })
    ];
  };
}
