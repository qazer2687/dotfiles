{
  lib,
  pkgs,
  config,
  ...
}: {
  options.homeModules.rider.enable = lib.mkEnableOption "Enable Jetbrains Rider.";

  config = lib.mkIf config.homeModules.rider.enable {
    home.packages = with pkgs; [
      jetbrains.rider
    ];
  };
}
