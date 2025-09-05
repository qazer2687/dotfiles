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
          immediate_render = true;
          disable_loading_bar = true;
          grace = 0;
          hide_cursor = true;
          no_fade_in = true;
        };
      };
    };
  };
}
