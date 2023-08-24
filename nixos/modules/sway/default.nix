wayland.windowManager.sway = {
      package = pkgs.swayfx;
      enable = true;
    };

    {
  lib,
  config,
  pkgs,
  ...
}: {
  options.systemModules.sway.ruby.enable = lib.mkEnableOption "";
  # Configuration
  config = lib.mkIf config.systemModules.sway.ruby.enable {
    programs.sway = {
      package = pkgs.swayfx;
      enable = true;
    };
  };
}