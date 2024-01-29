{
  lib,
  pkgs,
  config,
  ...
}: {
  options.modules.rider.enable = lib.mkEnableOption "Enable Jetbrains Rider.";

  config = lib.mkIf config.modules.rider.enable {
    home.packages = with pkgs; [
      jetbrains.rider
    ];
  };
}
