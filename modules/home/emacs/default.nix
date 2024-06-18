{
  lib,
  config,
  ...
}: {
  options.modules.emacs.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.emacs.enable {
    services.emacs = {
      enable = true;
      defaultEditor = true;
    };
  };
}
