{
  lib,
  config,
  ...
}: {
  options.modules.chromium.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.chromium.enable {
    programs.chromium = {
      enable = true;
    };
  };
}
