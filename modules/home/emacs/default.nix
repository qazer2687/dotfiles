{
  lib,
  config,
  pkgs,
  ...
}: {
  options.modules.emacs.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.emacs.enable {
    programs.emacs = {
      enable = true;
    };
  };
}
