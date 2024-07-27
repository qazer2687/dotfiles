{
  lib,
  config,
  pkgs,
  self,
  ...
}: {
  options.modules.edge.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.edge.enable {
    home.packages = with self.packages; [
      microsoft-edge
    ];
  };
}
