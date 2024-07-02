{
  lib,
  config,
  pkgs,
  ...
}: {
  options.modules.direnv.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.direnv.enable {
    programs.direnv = {
      enable = true;
      enableFishIntegration = true;
      nix-direnv = {
        enable = true;
      };
    };
  };
}
