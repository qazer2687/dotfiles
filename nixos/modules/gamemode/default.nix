{
  lib,
  config,
  ...
}: {
  options.systemModules.gamemode.enable = lib.mkEnableOption "";

  config = lib.mkIf config.systemModules.gamemode.enable {
    programs.gamemode = {
      enable = true;
    };
  };
}
