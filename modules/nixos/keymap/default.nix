{
  lib,
  config,
  pkgs,
  ...
}: {
  options.modules.keymap.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.keymap.enable {
    console.keyMap = "colemak";
    services.xserver.xkb = {
      layout = "gb";
      variant = "colemak";
    }; 
  };
}