{
  lib,
  config,
  pkgs,
  ...
}: {
  options.homeModules.obs.enable = lib.mkEnableOption "";
  config = lib.mkIf config.homeModules.obs.enable {
    programs.obs-studio = {
      enable = true;
      plugins = with pkgs.obs-studio-plugins; [
        wlrobs
        input-overlay
      ];
    };
  };
}
