{
  lib,
  config,
  ...
}: {
  options.homeModules.chromium.enable = lib.mkEnableOption "";

  config = lib.mkIf config.homeModules.chromium.enable {
    programs.chromium = {
      enable = true;
    };
  };
}
