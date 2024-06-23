{
  lib,
  config,
  pkgs,
  ...
}: {
  options.modules.edge.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.edge.enable {
    home.packages = with pkgs; [
      microsoft-edge
    ];
  };
}
