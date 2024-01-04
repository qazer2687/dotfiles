{
  lib,
  config,
  ...
}: {
  options.homeModules.mangohud.enable = lib.mkEnableOption "";

  config = lib.mkIf config.homeModules.mangohud.enable {
    programs.mangohud = {
      enable = true;
    };
  };
}
