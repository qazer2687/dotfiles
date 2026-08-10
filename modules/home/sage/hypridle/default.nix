{
  lib,
  config,
  ...
}: {
  options.modules.hypridle.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.hypridle.enable {
    services.hypridle = {
      enable = true;
      settings = {
        listener = [
          {
            timeout = 240;
            on-timeout = "hyprctl dispatch dpms off";
          }
        ];
      };
    };
  };
}
