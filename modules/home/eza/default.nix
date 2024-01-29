{
  lib,
  config,
  ...
}: {
  options.modules.eza.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.eza.enable {
    programs.eza = {
      enable = true;
      enableAliases = true;
      icons = true;
    };
  };
}
