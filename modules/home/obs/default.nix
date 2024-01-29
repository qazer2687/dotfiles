{
  lib,
  pkgs,
  config,
  ...
}: {
  options.modules.obs.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.obs.enable {
    programs.obs-studio = {
      enable = true;
      plugins = with pkgs.obs-studio-plugins; [
        wlrobs
        input-overlay
      ];
    };
  };
}
