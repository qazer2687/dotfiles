{
  lib,
  config,
  pkgs,
  ...
}: {
  options.modules.gpg.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.gpg.enable {
    programs.gpg = {
      enable = true;

      homedir = "${config.home.homeDirectory}/.gnupg";

      mutableKeys = true;
      mutableTrust = false;

      package = pkgs.gnupg;
    };

    services.gpg-agent = {
      enable = true;
      pinentryPackage = pkgs.pinentry;
      enableFishIntegration = true;
    };
  };
}
