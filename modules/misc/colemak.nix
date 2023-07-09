{ inputs, lib, config, pkgs, ... }: {

  options.modules.misc.colemak.enable = lib.mkEnableOption "";
  
  config = lib.mkIf config.modules.misc.colemak.enable {
    console.keyMap = "colemak";
    services.xserver = {
      layout = "gb";
      xkbVariant = "colemak";
    };
  };
}