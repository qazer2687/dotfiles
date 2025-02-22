{
  lib,
  config,
  pkgs,
  inputs,
  ...
}: {
  options.modules.hyprlock.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.hyprlock.enable {
    programs.hyprlock = {
      enable = true;
    };
  };
}
