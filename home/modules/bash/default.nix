{
  lib,
  config,
  ...
}: {
  options.homeModules.bash.enable = lib.mkEnableOption "";

  config = lib.mkIf config.homeModules.bash.enable {
    programs.bash = {
      enable = true;
      bashrcExtra = ''
      eval "$(direnv hook bash)"
      '';
    };
  };
}
