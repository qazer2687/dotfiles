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
            timeout = 150;
            on-timeout = "hyprctl dispatch dpms off";
            on-resume = "hyprctl dispatch dpms on";
          }
        ];
      };
    };
  };
}
