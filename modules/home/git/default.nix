{
  lib,
  config,
  ...
}: {
  options.modules.git.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.git.enable {
    programs.git = {
      enable = true;
      userName = "q";
      #userName = config.sops.secrets."github-user-name".path;
      userEmail = "114782572+ihatewindows@users.noreply.github.com";
      #userEmail = config.sops.secrets."github-user-email".path;
    };
  };
}
