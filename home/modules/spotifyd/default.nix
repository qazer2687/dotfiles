{
  lib,
  config,
  ...
}: {
  options.homeModules.spotifyd.enable = lib.mkEnableOption "";

  config = lib.mkIf config.homeModules.spotifyd.enable {
    # Installation
    services.spotifyd = {
      enable = true;
      settings = {
        global = {
          username = "3fl3wvehzpuudbzovifsyndbp";
          password_cmd = "/home/alex/.config/spotifyd/readPassword.sh";
        };
      };
    };

    # Password
    sops.secrets."spotify/password".path = "/home/alex/.config/spotifyd/password";

    # Configuration
    xdg.configFile."spotifyd/readPassword.sh".text = builtins.readFile ./scripts/readPassword.sh;
    xdg.configFile."spotifyd/readPassword.sh".executable = true;
  };
}
