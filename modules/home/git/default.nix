{
  lib,
  config,
  pkgs,
  ...
}: {
  options.modules.git.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.git.enable {
    programs.git = {
      enable = true;
      userName = "qazer2687";
      userEmail = "114782572+qazer2687@users.noreply.github.com";
      # TODO: use sops to retrieve details
      extraConfig = {
        credential.helper = "
          ${
            pkgs.git.override {
              withLibsecret = true;
            }
          }
          /bin/git-credential-libsecret
        ";
      };
    };
    home.packages = [ pkgs.gitFull ];
  };
}
