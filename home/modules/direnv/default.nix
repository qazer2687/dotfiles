{
  lib,
  config,
  ...
}: {
  options.homeModules.direnv.enable = lib.mkEnableOption "";

  config = lib.mkIf config.homeModules.direnv.enable {
    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };
}
