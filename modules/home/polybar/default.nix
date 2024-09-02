{
  lib,
  config,
  pkgs,
  ...
}: {
  options.modules.polybar.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.polybar.enable {
    services.polybar = {
      enable = true;
      config = builtins.readFile ./config/default;
      script = builtins.readFile ./config/launch.sh;
    };
  };
}
