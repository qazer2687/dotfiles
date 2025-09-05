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
          grace = 0;
          hide_cursor = true;
        };
      };
    };
  };
}
