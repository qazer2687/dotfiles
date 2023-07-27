{
  lib,
  config,
  ...
}: {
  options.homeModules.programs.bash.enable = lib.mkEnableOption "";

  config = lib.mkIf config.homeModules.programs.bash.enable {
    programs.bash.enable = true;
  };
}
