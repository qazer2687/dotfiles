{
  lib,
  config,
  pkgs,
  ...
}: {
  options.homeModules.starship.enable = lib.mkEnableOption "";

  config = lib.mkIf config.homeModules.starship.enable {
    programs.bash = {
      enable = true;
      bashrcExtra = ''
        eval "$(direnv hook bash)"
      ''
    };
  };
}
