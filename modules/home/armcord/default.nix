{
  lib,
  config,
  pkgs,
  ...
}: {
  options.modules.armcord.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.armcord.enable {
    home.packages = with pkgs; [
      armcord
    ];
  };
}
