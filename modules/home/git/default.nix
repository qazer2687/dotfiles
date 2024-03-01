{
  lib,
  config,
  ...
}: {
  options.modules.git.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.git.enable {
    programs.git = {
      enable = true;
      userName = config.sops.secrets."github-user-name".path;
      userEmail = config.sops.secrets."github-user-email".path;
    };
  };
}
