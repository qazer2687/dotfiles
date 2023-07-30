{
  lib,
  config,
  ...
}: {
  options.homeModules.services.spotifyd.enable = lib.mkEnableOption "";

  config = lib.mkIf config.homeModules.services.spotifyd.enable {
    # Installation
    services.spotifyd = {
      enable = true;
    };

    # Configuration
    xdg.configFile."spotifyd/spotifyd.conf".text = builtins.readFile ./spotifyd.conf;
    xdg.configFile."spotifyd/read_password.sh".text = builtins.readFile ./read_password.sh;
    xdg.configFile."spotifyd/read_password.sh".executable = true;
  };
}
