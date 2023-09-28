{
  lib,
  config,
  ...
}: {
  options.homeModules.rider.enable = lib.mkEnableOption "";

  config = lib.mkIf config.homeModules.rider.enable {
    home.packages = with pkgs; [
      jetbrains.rider
    ];
  };
}
