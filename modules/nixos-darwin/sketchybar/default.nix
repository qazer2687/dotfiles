{
  lib,
  config,
  pkgs,
  ...
}: {
  options.modules.sketchybar.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.sketchybar.enable {
    services.sketchybar = {
      enable = true;
      package = pkgs.sketchybar;
      config = builtins.readFile .config/default.nix;
    };
  };
}
