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
      mutableKeys = false;
      mutableTrust = false;
      package = pkgs.gnupg;

      # Trust Levels
      # 1 = Unknown
      # 2 = Never
      # 3 = Marginal
      # 4 = Full
      # 5 = Ultimate

      publicKeys = [
        # Michaili
        {
          text = builtins.fetchurl {
            url = "https://github.com/MichailiK.gpg";
            sha256 = "b97af827ff77670cb174f5a6ed040e651b89ab90df02ecb1655209ac6b9efea7";
          };
          trust = 4;
        }
      ];
    };

    services.gpg-agent = {
      enable = true;
      pinentryPackage = pkgs.pinentry;
      enableFishIntegration = true;
    };
  };
}
