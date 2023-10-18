{
  lib,
  pkgs,
  ...
}: {
  options.homeModules.rider.enable = lib.mkEnableOption "Enable Jetbrains Rider.";

  config = {
    homeModules.rider.enable = {
      home.packages = with pkgs; [
        jetbrains.rider
      ];
    };
  };
}
