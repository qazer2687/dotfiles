{
  lib,
  config,
  ...
}: {
  options.modules.direnv.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.direnv.enable {
    programs.direnv = {
      enable = true;
      loadInNixShell = true;
      silent = true;
      nix-direnv = {
        enable = true;
      };
    };
  };
}
