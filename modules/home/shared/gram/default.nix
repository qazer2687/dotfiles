{
  lib,
  config,
  ...
}: {
  options.modules.gram.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.gram.enable {
    programs.gram = {
      enable = true;
    };
  };
}
