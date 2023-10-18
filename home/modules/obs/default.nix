{
  lib,
  pkgs,
  ...
}: {
  options.homeModules.obs.enable = lib.mkEnableOption "";

  config = {
    homeModules.obs.enable = {
      programs.obs-studio = {
        enable = true;
        plugins = with pkgs.obs-studio-plugins; [
          wlrobs
          input-overlay
        ];
      };
    };
  };
}
