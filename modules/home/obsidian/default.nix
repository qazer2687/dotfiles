{
  lib,
  config,
  pkgs,
  ...
}: {
  options.homeModules.obsidian.enable = lib.mkEnableOption "";

  config = lib.mkIf config.homeModules.obsidian.enable {
    home.packages = with pkgs; [
      obsidian
    ];
  };
}
