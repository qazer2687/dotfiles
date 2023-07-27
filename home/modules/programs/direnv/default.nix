{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  options.homeModules.programs.direnv.enable = lib.mkEnableOption "";

  config = lib.mkIf config.homeModules.programs.direnv.enable {
    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };
}
