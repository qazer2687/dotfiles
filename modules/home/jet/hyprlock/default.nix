{
  lib,
  config,
  ...
}: {
  options.modules.hyprlock.enable = lib.mkEnableOption "";
  
  config = lib.mkIf config.modules.hyprlock.enable {
    programs.hyprlock = {
      enable = true;
      settings = {
        general = {
          # Doesn't work with GPU accel.
          screencopy_mode = 1;
          hide_cursor = true;
        };
      };
    };
  };
}
